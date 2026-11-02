import 'package:mumble_protocol/mumble_protocol.dart';
import 'package:test/test.dart';

MumbleChannel ch(int id, String name, int parent, {int position = 0}) =>
    MumbleChannel(
      id: id,
      name: name,
      parentId: parent,
      position: position,
    );

void main() {
  group('频道增量', () {
    test('新建频道', () {
      final state = ServerState()
        ..applyChannelState(
          ChannelState(channelId: 1, parent: 0, name: '大厅'),
        );

      expect(state.channels[1]!.name, equals('大厅'));
      expect(state.channels[1]!.parentId, equals(0));
    });

    test('改名与移动是增量，不影响其他字段', () {
      final state = ServerState()
        ..applyChannelState(
          ChannelState(channelId: 1, parent: 0, name: '大厅', position: 3),
        )
        ..applyChannelState(ChannelState(channelId: 1, name: '主厅'))
        ..applyChannelState(ChannelState(channelId: 1, parent: 2));

      final channel = state.channels[1]!;
      expect(channel.name, equals('主厅'));
      expect(channel.parentId, equals(2));
      expect(channel.position, equals(3), reason: '没传 position 就不该被覆盖');
    });

    test('频道链接的增删', () {
      final state = ServerState()
        ..applyChannelState(
          ChannelState(channelId: 1, parent: 0, name: 'A', links: [2]),
        )
        ..applyChannelState(ChannelState(channelId: 1, linksAdd: [3]))
        ..applyChannelState(ChannelState(channelId: 1, linksRemove: [2]));

      expect(state.channels[1]!.linkedChannels, equals([3]));
    });

    test('删除频道', () {
      final state = ServerState()
        ..applyChannelState(ChannelState(channelId: 1, parent: 0, name: 'A'))
        ..applyChannelRemove(ChannelRemove(channelId: 1));

      expect(state.channels, isEmpty);
    });

    test('子频道按 position 排序，position 相同按名字', () {
      final state = ServerState()
        ..applyChannelState(ChannelState(channelId: 1, parent: 0, name: 'B', position: 2))
        ..applyChannelState(ChannelState(channelId: 2, parent: 0, name: 'A', position: 2))
        ..applyChannelState(ChannelState(channelId: 3, parent: 0, name: 'Z', position: 1));

      final children = state.childrenOf(0).map((c) => c.name).toList();
      expect(children, equals(['Z', 'A', 'B']));
    });
  });

  group('用户增量', () {
    test('新建用户', () {
      final state = ServerState()
        ..applyUserState(
          UserState(session: 7, name: '小明', channelId: 1),
        );

      expect(state.users[7]!.name, equals('小明'));
      expect(state.users[7]!.channelId, equals(1));
    });

    test('换频道不影响其他状态', () {
      final state = ServerState()
        ..applyUserState(
          UserState(session: 7, name: '小明', channelId: 1, selfMute: true),
        )
        ..applyUserState(UserState(session: 7, channelId: 2));

      final user = state.users[7]!;
      expect(user.channelId, equals(2));
      expect(user.selfMute, isTrue);
      expect(user.name, equals('小明'));
    });

    test('服务端静音与自我静音是两回事', () {
      final state = ServerState()
        ..applyUserState(UserState(session: 7, name: '小明', channelId: 1))
        ..applyUserState(UserState(session: 7, selfMute: true))
        ..applyUserState(UserState(session: 7, mute: true));

      expect(state.users[7]!.selfMute, isTrue);
      expect(state.users[7]!.mute, isTrue);
    });

    test('用户离开', () {
      final state = ServerState()
        ..applyUserState(UserState(session: 7, name: '小明', channelId: 1))
        ..applyUserRemove(UserRemove(session: 7));

      expect(state.users, isEmpty);
    });

    test('频道内用户按名字排序', () {
      final state = ServerState()
        ..applyUserState(UserState(session: 1, name: 'Charlie', channelId: 5))
        ..applyUserState(UserState(session: 2, name: 'Alice', channelId: 5))
        ..applyUserState(UserState(session: 3, name: 'Bob', channelId: 6));

      expect(
        state.usersIn(5).map((u) => u.name),
        equals(['Alice', 'Charlie']),
      );
    });
  });

  group('服务器同步', () {
    test('ServerSync 写入自身 session 与欢迎语', () {
      final state = ServerState()
        ..applyServerSync(
          ServerSync(session: 42, welcomeText: '欢迎', maxBandwidth: 72000),
        );

      expect(state.selfSession, equals(42));
      expect(state.welcomeText, equals('欢迎'));
      expect(state.maxBandwidth, equals(72000));
    });

    test('ServerConfig 更新带宽与录音策略', () {
      final state = ServerState()
        ..applyServerConfig(
          ServerConfig(maxBandwidth: 128000, recordingAllowed: false),
        );

      expect(state.maxBandwidth, equals(128000));
      expect(state.allowRecording, isFalse);
    });
  });

  test('self 快捷方式', () {
    final state = ServerState()
      ..applyUserState(UserState(session: 42, name: '我', channelId: 1))
      ..applyServerSync(ServerSync(session: 42));

    expect(state.self?.name, equals('我'));
  });
}
