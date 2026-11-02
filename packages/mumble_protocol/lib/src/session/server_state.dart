import '../proto/Mumble.pb.dart';

/// 一个频道。字段对应 `MumbleProto.ChannelState`，但只保留我们会用到的部分。
class MumbleChannel {
  MumbleChannel({
    required this.id,
    this.parentId = 0,
    this.name = '',
    this.description = '',
    this.position = 0,
    this.temporary = false,
    this.maxUsers = 0,
    List<int>? linkedChannels,
  }) : linkedChannels = linkedChannels ?? <int>[];

  final int id;
  int parentId;
  String name;
  String description;
  int position;
  bool temporary;
  int maxUsers;
  List<int> linkedChannels;

  @override
  String toString() => 'MumbleChannel($id, "$name", parent=$parentId)';
}

/// 一个在线用户。对应 `MumbleProto.UserState` 的子集。
class MumbleUser {
  MumbleUser({
    required this.session,
    this.name = '',
    this.channelId = 0,
    this.userId,
    this.selfMute = false,
    this.selfDeaf = false,
    this.mute = false,
    this.deaf = false,
    this.suppress = false,
    this.prioritySpeaker = false,
    this.recording = false,
  });

  final int session;
  String name;
  int channelId;

  /// 注册用户 id；未注册为 null。
  int? userId;

  bool selfMute;
  bool selfDeaf;
  bool mute;
  bool deaf;
  bool suppress;
  bool prioritySpeaker;
  bool recording;

  @override
  String toString() => 'MumbleUser($session, "$name", ch=$channelId)';
}

/// 服务器快照：频道树 + 用户表 + 服务器配置。
///
/// 只做**增量应用**，不发网络请求。所有方法都是同步的，方便测试。
class ServerState {
  final Map<int, MumbleChannel> channels = <int, MumbleChannel>{};
  final Map<int, MumbleUser> users = <int, MumbleUser>{};

  /// 自己的 session（来自 `ServerSync`）。
  int? selfSession;

  /// 服务器欢迎语（`ServerSync.welcome_text`）。
  String? welcomeText;

  /// 最大带宽（bit/s）。
  int maxBandwidth = 0;

  /// 是否允许录音。
  bool allowRecording = true;

  MumbleUser? get self => selfSession == null ? null : users[selfSession];

  /// 按父频道分组，根频道（id=0）在最前。
  List<MumbleChannel> childrenOf(int parentId) {
    final list = channels.values.where((c) => c.parentId == parentId).toList()
      ..sort((a, b) {
        final byPos = a.position.compareTo(b.position);
        return byPos != 0 ? byPos : a.name.compareTo(b.name);
      });
    return list;
  }

  /// 频道内用户（按名字排序）。
  List<MumbleUser> usersIn(int channelId) {
    final list = users.values.where((u) => u.channelId == channelId).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return list;
  }

  // ---------------------------------------------------------------------------
  // 增量应用
  // ---------------------------------------------------------------------------

  void applyChannelState(ChannelState msg) {
    if (!msg.hasChannelId()) return;
    final id = msg.channelId;
    final existing = channels[id];

    if (existing == null) {
      channels[id] = MumbleChannel(
        id: id,
        parentId: msg.hasParent() ? msg.parent : 0,
        name: msg.hasName() ? msg.name : '',
        description: msg.hasDescription() ? msg.description : '',
        position: msg.hasPosition() ? msg.position : 0,
        temporary: msg.hasTemporary() && msg.temporary,
        maxUsers: msg.hasMaxUsers() ? msg.maxUsers : 0,
        linkedChannels: msg.links.toList(),
      );
      return;
    }

    if (msg.hasParent()) existing.parentId = msg.parent;
    if (msg.hasName()) existing.name = msg.name;
    if (msg.hasDescription()) existing.description = msg.description;
    if (msg.hasPosition()) existing.position = msg.position;
    if (msg.hasTemporary()) existing.temporary = msg.temporary;
    if (msg.hasMaxUsers()) existing.maxUsers = msg.maxUsers;
    if (msg.links.isNotEmpty) existing.linkedChannels = msg.links.toList();
    for (final link in msg.linksAdd) {
      if (!existing.linkedChannels.contains(link)) {
        existing.linkedChannels.add(link);
      }
    }
    for (final link in msg.linksRemove) {
      existing.linkedChannels.remove(link);
    }
  }

  void applyChannelRemove(ChannelRemove msg) {
    channels.remove(msg.channelId);
  }

  void applyUserState(UserState msg) {
    if (!msg.hasSession()) return;
    final session = msg.session;
    final user = users.putIfAbsent(
      session,
      () => MumbleUser(session: session),
    );

    if (msg.hasName()) user.name = msg.name;
    if (msg.hasChannelId()) user.channelId = msg.channelId;
    if (msg.hasUserId()) user.userId = msg.userId;
    if (msg.hasSelfMute()) user.selfMute = msg.selfMute;
    if (msg.hasSelfDeaf()) user.selfDeaf = msg.selfDeaf;
    if (msg.hasMute()) user.mute = msg.mute;
    if (msg.hasDeaf()) user.deaf = msg.deaf;
    if (msg.hasSuppress()) user.suppress = msg.suppress;
    if (msg.hasPrioritySpeaker()) user.prioritySpeaker = msg.prioritySpeaker;
    if (msg.hasRecording()) user.recording = msg.recording;
  }

  void applyUserRemove(UserRemove msg) {
    users.remove(msg.session);
  }

  void applyServerSync(ServerSync msg) {
    if (msg.hasSession()) selfSession = msg.session;
    if (msg.hasWelcomeText()) welcomeText = msg.welcomeText;
    if (msg.hasMaxBandwidth()) maxBandwidth = msg.maxBandwidth;
    if (msg.hasPermissions()) {
      // 权限位是 64 位掩码，先原样保存（后续 ACL 模块使用）。
    }
  }

  void applyServerConfig(ServerConfig msg) {
    if (msg.hasMaxBandwidth()) maxBandwidth = msg.maxBandwidth;
    if (msg.hasRecordingAllowed()) allowRecording = msg.recordingAllowed;
  }
}
