import 'dart:async';

import '../wire/frame.dart';

/// 控制通道的传输抽象。
///
/// 之所以要这个接口：TCP/TLS、UDP 隧道、内存（测试）三条路径共用同一套
/// 会话逻辑。**只有这一个是必须抽象的**——它有两个以上真实实现。
abstract interface class ITransport {
  /// 收到的帧。订阅者需要在 [connect] 之前挂上，避免丢首包。
  Stream<ControlFrame> get frames;

  /// 发送一帧。调用方负责把 protobuf 序列化好。
  void send(ControlFrame frame);

  /// 关闭连接。幂等。
  Future<void> close();

  /// 是否已关闭。
  bool get isClosed;
}

/// 内存传输：两端直连，用于测试与协议回放。
///
/// 用法：
/// ```dart
/// final (client, server) = MemoryTransport.pair();
/// ```
class MemoryTransport implements ITransport {
  MemoryTransport._(this._incoming, this._outgoing);

  final Stream<ControlFrame> _incoming;
  final StreamController<ControlFrame> _outgoing;
  bool _closed = false;

  /// 造一对互相连通的端点。返回 `(客户端, 服务端)`。
  static (MemoryTransport, MemoryTransport) pair() {
    final aToB = StreamController<ControlFrame>();
    final bToA = StreamController<ControlFrame>();

    final a = MemoryTransport._(bToA.stream, aToB);
    final b = MemoryTransport._(aToB.stream, bToA);
    return (a, b);
  }

  @override
  Stream<ControlFrame> get frames => _incoming;

  @override
  void send(ControlFrame frame) {
    if (_closed) {
      throw StateError('MemoryTransport: 已关闭，不能再发送');
    }
    _outgoing.add(frame);
  }

  @override
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    // 注意：**不要 await**。StreamController.close() 的 Future 只有在
    // 有人监听并收到 done 事件后才完成；对端没监听时 await 会永久挂起。
    unawaited(_outgoing.close());
  }

  @override
  bool get isClosed => _closed;
}
