import 'dart:async';
import 'dart:typed_data';

import 'package:protobuf/protobuf.dart';

import '../proto/Mumble.pb.dart';
import '../transport/transport.dart';
import '../wire/frame.dart';
import 'server_state.dart';

/// 会话所处的阶段。
enum SessionPhase {
  /// 还没开始。
  idle,

  /// 已发出 Version，等待/进行认证。
  connecting,

  /// 已收到 ServerSync，可以使用。
  synced,

  /// 已关闭。
  closed,
}

/// 认证凭据。
class MumbleCredentials {
  const MumbleCredentials({
    required this.username,
    this.password,
    this.tokens = const <String>[],
  });

  final String username;
  final String? password;

  /// 访问令牌（服务器配置里的 `channel` 权限用），一般不用。
  final List<String> tokens;
}

/// Mumble 版本号编码：`(major << 16) | (minor << 8) | patch`。
abstract final class MumbleVersion {
  static const int major = 1;
  static const int minor = 5;
  static const int patch = 0;

  static int get encoded => (major << 16) | (minor << 8) | patch;

  static String get release => 'McooVoice 0.1.0';
}

/// 会话事件。UI/上层订阅这个流，不直接读内部状态。
sealed class SessionEvent {
  const SessionEvent();
}

/// 握手完成，可以发消息了。
final class SessionReady extends SessionEvent {
  const SessionReady();
}

/// 连接关闭。
final class SessionClosed extends SessionEvent {
  const SessionClosed({this.reason});

  final String? reason;
}

/// 收到文本消息。
final class SessionTextMessage extends SessionEvent {
  const SessionTextMessage(this.message);

  final TextMessage message;
}

/// 频道状态变化（含新建）。
final class SessionChannelChanged extends SessionEvent {
  const SessionChannelChanged(this.message);

  final ChannelState message;
}

/// 用户状态变化（含新用户）。
final class SessionUserChanged extends SessionEvent {
  const SessionUserChanged(this.message);

  final UserState message;
}

/// 用户离开。
final class SessionUserRemoved extends SessionEvent {
  const SessionUserRemoved(this.message);

  final UserRemove message;
}

/// 权限被拒。
final class SessionPermissionDenied extends SessionEvent {
  const SessionPermissionDenied(this.message);

  final PermissionDenied message;
}

/// 被服务器拒绝连接。
class SessionRejectedException implements Exception {
  SessionRejectedException(this.reject);

  final Reject reject;

  @override
  String toString() =>
      'SessionRejectedException(type=${reject.type}, reason="${reject.reason}")';
}

/// 一个 Mumble 会话：负责握手、维持 [ServerState]、收发消息。
///
/// 它**不关心传输是什么**——TCP/TLS、内存传输都一样，只要实现 [ITransport]。
class MumbleSession {
  MumbleSession(
    this._transport, {
    required this.credentials,
    this.handshakeTimeout = const Duration(seconds: 15),
    this.osName = 'Unknown',
  });

  final ITransport _transport;
  final MumbleCredentials credentials;
  final Duration handshakeTimeout;
  final String osName;

  final ServerState state = ServerState();
  final StreamController<SessionEvent> _events =
      StreamController<SessionEvent>.broadcast();

  StreamSubscription<ControlFrame>? _subscription;
  Completer<void>? _synced;
  SessionPhase _phase = SessionPhase.idle;

  Stream<SessionEvent> get events => _events.stream;
  SessionPhase get phase => _phase;

  /// 握手：发 Version + Authenticate，等 ServerSync。
  ///
  /// 超时抛 [TimeoutException]，被拒抛 [SessionRejectedException]。
  Future<void> connect() async {
    if (_phase != SessionPhase.idle) {
      throw StateError('MumbleSession: 只能 connect 一次（当前 $_phase）');
    }

    _phase = SessionPhase.connecting;
    _synced = Completer<void>();
    _subscription = _transport.frames.listen(
      _onFrame,
      onError: (Object error, StackTrace st) => _fail(error),
      onDone: _onTransportDone,
      cancelOnError: false,
    );

    _send(MessageType.version, _buildVersion());
    _send(MessageType.authenticate, _buildAuthenticate());

    try {
      await _synced!.future.timeout(handshakeTimeout);
    } on TimeoutException {
      await close();
      throw TimeoutException(
        '握手超时：${handshakeTimeout.inSeconds}s 内没收到 ServerSync',
        handshakeTimeout,
      );
    }

    _phase = SessionPhase.synced;
    _events.add(const SessionReady());
  }

  /// 发一条文本消息。给了 [channelId] 就是频道消息，给了 [sessions] 就是私聊。
  void sendTextMessage({
    int? channelId,
    List<int>? sessions,
    required String message,
  }) {
    _requireSynced();
    final msg = TextMessage(message: message);
    if (channelId != null) msg.channelId.add(channelId);
    if (sessions != null) msg.session.addAll(sessions);
    _send(MessageType.textMessage, msg);
  }

  /// 切换自己所在的频道。
  void moveToChannel(int channelId) {
    _requireSynced();
    final selfSession = state.selfSession;
    if (selfSession == null) {
      throw StateError('MumbleSession: 还没拿到自己的 session');
    }
    _send(
      MessageType.userState,
      UserState(session: selfSession, channelId: channelId),
    );
  }

  Future<void> close() async {
    if (_phase == SessionPhase.closed) return;
    _phase = SessionPhase.closed;

    await _subscription?.cancel();
    _subscription = null;
    await _transport.close();

    if (_synced != null && !_synced!.isCompleted) {
      _synced!.completeError(StateError('连接已关闭'));
    }
    if (!_events.isClosed) {
      _events.add(const SessionClosed());
      // 同样不能 await：没有监听者时 close() 的 Future 不会完成。
      unawaited(_events.close());
    }
  }

  // ---------------------------------------------------------------------------
  // 内部
  // ---------------------------------------------------------------------------

  void _requireSynced() {
    if (_phase != SessionPhase.synced) {
      throw StateError('MumbleSession: 还没握手完成（当前 $_phase）');
    }
  }

  void _send(int type, GeneratedMessage message) {
    _transport.send(
      ControlFrame(type, Uint8List.fromList(message.writeToBuffer())),
    );
  }

  Version _buildVersion() => Version(
        versionV1: MumbleVersion.encoded,
        release: MumbleVersion.release,
        os: osName,
      );

  Authenticate _buildAuthenticate() {
    final msg = Authenticate(
      username: credentials.username,
      opus: true,
      tokens: credentials.tokens,
    );
    if (credentials.password != null) {
      msg.password = credentials.password!;
    }
    return msg;
  }

  void _onFrame(ControlFrame frame) {
    switch (frame.type) {
      case MessageType.channelState:
        final msg = ChannelState.fromBuffer(frame.payload);
        state.applyChannelState(msg);
        _emit(SessionChannelChanged(msg));

      case MessageType.channelRemove:
        final msg = ChannelRemove.fromBuffer(frame.payload);
        state.applyChannelRemove(msg);

      case MessageType.userState:
        final msg = UserState.fromBuffer(frame.payload);
        state.applyUserState(msg);
        _emit(SessionUserChanged(msg));

      case MessageType.userRemove:
        final msg = UserRemove.fromBuffer(frame.payload);
        state.applyUserRemove(msg);
        _emit(SessionUserRemoved(msg));

      case MessageType.textMessage:
        _emit(SessionTextMessage(TextMessage.fromBuffer(frame.payload)));

      case MessageType.permissionDenied:
        _emit(SessionPermissionDenied(
          PermissionDenied.fromBuffer(frame.payload),
        ));

      case MessageType.serverSync:
        final msg = ServerSync.fromBuffer(frame.payload);
        state.applyServerSync(msg);
        if (_synced != null && !_synced!.isCompleted) {
          _synced!.complete();
        }

      case MessageType.serverConfig:
        state.applyServerConfig(ServerConfig.fromBuffer(frame.payload));

      case MessageType.reject:
        _fail(SessionRejectedException(Reject.fromBuffer(frame.payload)));

      case MessageType.ping:
        // 服务器心跳，回一个同样的时间戳即可（M2 再做 RTT 统计）。
        _send(MessageType.ping, Ping.fromBuffer(frame.payload));

      case MessageType.udpTunnel:
        // 裸语音包，M2 交给音频层处理。
        break;

      default:
        // 未知/暂不处理的消息：忽略，不抛错（服务器可能比我们新）。
        break;
    }
  }

  void _emit(SessionEvent event) {
    if (!_events.isClosed) _events.add(event);
  }

  void _fail(Object error) {
    if (_synced != null && !_synced!.isCompleted) {
      _synced!.completeError(error);
    }
  }

  void _onTransportDone() {
    if (_phase == SessionPhase.closed) return;
    _phase = SessionPhase.closed;
    _emit(const SessionClosed());
    _fail(StateError('传输已断开'));
  }
}
