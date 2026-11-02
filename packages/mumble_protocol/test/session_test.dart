import 'dart:async';
import 'dart:typed_data';

import 'package:mumble_protocol/mumble_protocol.dart';
import 'package:protobuf/protobuf.dart';
import 'package:test/test.dart';

/// 测试用的假服务器：收帧、回帧，不解析语义。
class FakeServer {
  FakeServer(this.transport) {
    _subscription = transport.frames.listen(received.add);
  }

  final ITransport transport;
  final List<ControlFrame> received = <ControlFrame>[];
  late final StreamSubscription<ControlFrame> _subscription;

  void send(int type, GeneratedMessage message) {
    transport.send(
      ControlFrame(type, Uint8List.fromList(message.writeToBuffer())),
    );
  }

  Future<void> dispose() async {
    await _subscription.cancel();
    await transport.close();
  }
}

void main() {
  late MemoryTransport clientSide;
  late MemoryTransport serverSide;
  late FakeServer server;

  setUp(() {
    final (client, srv) = MemoryTransport.pair();
    clientSide = client;
    serverSide = srv;
    server = FakeServer(serverSide);
  });

  tearDown(() async {
    await server.dispose();
  });

  group('握手', () {
    test('先发 Version 再发 Authenticate', () async {
      final session = MumbleSession(
        clientSide,
        credentials: const MumbleCredentials(
          username: '小明',
          password: 'secret',
        ),
        osName: 'Windows',
      );

      final connecting = session.connect();
      await pumpEventQueue();

      expect(server.received, hasLength(2));
      expect(server.received[0].type, equals(MessageType.version));
      expect(server.received[1].type, equals(MessageType.authenticate));

      final version = Version.fromBuffer(server.received[0].payload);
      expect(version.versionV1, equals(MumbleVersion.encoded));
      expect(version.os, equals('Windows'));

      final auth = Authenticate.fromBuffer(server.received[1].payload);
      expect(auth.username, equals('小明'));
      expect(auth.password, equals('secret'));
      expect(auth.opus, isTrue);

      server.send(MessageType.serverSync, ServerSync(session: 42));
      await pumpEventQueue();
      await connecting;

      expect(session.phase, equals(SessionPhase.synced));
      expect(session.state.selfSession, equals(42));
    });

    test('握手期间收到的频道/用户状态会被缓存下来', () async {
      final session = MumbleSession(
        clientSide,
        credentials: const MumbleCredentials(username: '小明'),
      );

      final connecting = session.connect();
      await pumpEventQueue();

      server.send(
        MessageType.channelState,
        // 根频道没有 parent（proto 里是 uint32，不能写 -1）。
        ChannelState(channelId: 0, name: '根频道'),
      );
      server.send(
        MessageType.channelState,
        ChannelState(channelId: 1, parent: 0, name: '大厅'),
      );
      server.send(
        MessageType.userState,
        UserState(session: 42, name: '小明', channelId: 1),
      );
      server.send(MessageType.serverSync, ServerSync(session: 42));
      await pumpEventQueue();
      await connecting;

      expect(session.state.channels, hasLength(2));
      expect(session.state.channels[1]!.name, equals('大厅'));
      expect(session.state.users[42]!.name, equals('小明'));
      expect(session.state.self?.channelId, equals(1));
    });

    test('被拒绝时抛 SessionRejectedException', () async {
      final session = MumbleSession(
        clientSide,
        credentials: const MumbleCredentials(username: '小明'),
      );

      final connecting = session.connect();
      // 必须在推进事件队列之前挂上期望，否则 future 会先以「未处理错误」爆掉。
      final expectation =
          expectLater(connecting, throwsA(isA<SessionRejectedException>()));

      await pumpEventQueue();
      server.send(
        MessageType.reject,
        Reject(type: Reject_RejectType.WrongUserPW, reason: '密码错误'),
      );
      await pumpEventQueue();

      await expectation;
    });

    test('服务器不说话时握手超时', () async {
      final session = MumbleSession(
        clientSide,
        credentials: const MumbleCredentials(username: '小明'),
        handshakeTimeout: const Duration(milliseconds: 80),
      );

      await expectLater(
        session.connect(),
        throwsA(isA<TimeoutException>()),
      );
    });

    test('握手完成前发消息会抛错', () {
      final session = MumbleSession(
        clientSide,
        credentials: const MumbleCredentials(username: '小明'),
      );

      expect(
        () => session.sendTextMessage(channelId: 0, message: 'hi'),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('握手之后', () {
    Future<MumbleSession> connected() async {
      final session = MumbleSession(
        clientSide,
        credentials: const MumbleCredentials(username: '小明'),
      );
      final connecting = session.connect();
      await pumpEventQueue();
      server.send(MessageType.serverSync, ServerSync(session: 42));
      server.send(
        MessageType.userState,
        UserState(session: 42, name: '小明', channelId: 1),
      );
      await pumpEventQueue();
      await connecting;
      return session;
    }

    test('发频道文本消息', () async {
      final session = await connected();
      server.received.clear();

      session.sendTextMessage(channelId: 1, message: '去拿快递了');
      await pumpEventQueue();

      expect(server.received, hasLength(1));
      expect(server.received.single.type, equals(MessageType.textMessage));

      final text = TextMessage.fromBuffer(server.received.single.payload);
      expect(text.message, equals('去拿快递了'));
      expect(text.channelId, equals([1]));
    });

    test('发私聊', () async {
      final session = await connected();
      server.received.clear();

      session.sendTextMessage(sessions: [7, 8], message: '悄悄话');
      await pumpEventQueue();

      final text = TextMessage.fromBuffer(server.received.single.payload);
      expect(text.session, equals([7, 8]));
      expect(text.channelId, isEmpty);
    });

    test('切频道用 UserState 带自己的 session', () async {
      final session = await connected();
      server.received.clear();

      session.moveToChannel(2);
      await pumpEventQueue();

      expect(server.received.single.type, equals(MessageType.userState));
      final state = UserState.fromBuffer(server.received.single.payload);
      expect(state.session, equals(42));
      expect(state.channelId, equals(2));
    });

    test('收到文本消息会变成事件', () async {
      final session = await connected();
      final events = <SessionEvent>[];
      session.events.listen(events.add);

      server.send(
        MessageType.textMessage,
        TextMessage(actor: 7, message: '你好', channelId: [1]),
      );
      await pumpEventQueue();

      final textEvent = events.whereType<SessionTextMessage>().single;
      expect(textEvent.message.message, equals('你好'));
    });

    test('关闭后不能再发消息', () async {
      final session = await connected();
      await session.close();

      expect(session.phase, equals(SessionPhase.closed));
      expect(
        () => session.sendTextMessage(channelId: 1, message: 'hi'),
        throwsA(isA<StateError>()),
      );
    });
  });

  test('内存传输：一端关闭，另一端收到流结束', () async {
    final (a, b) = MemoryTransport.pair();
    var done = false;
    b.frames.listen((_) {}, onDone: () => done = true);

    a.send(ControlFrame(MessageType.ping, Uint8List.fromList([1])));
    await a.close();
    await pumpEventQueue();

    expect(done, isTrue);
    expect(a.isClosed, isTrue);
  });
}
