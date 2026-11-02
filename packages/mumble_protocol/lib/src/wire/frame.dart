import 'dart:typed_data';

/// TCP 控制通道分帧。
///
/// 帧格式（官方 docs/dev/network-protocol/protocol_stack_tcp.md）：
///
/// ```
/// [2 字节 消息类型, big-endian][4 字节 载荷长度, big-endian][载荷]
/// ```
///
/// **例外**：类型 1（`UDPTunnel`）的载荷是裸语音包，不是 protobuf，
/// 解析时不能走 protobuf 解码。
class ControlFrame {
  const ControlFrame(this.type, this.payload);

  final int type;
  final Uint8List payload;

  /// 帧头长度。
  static const int headerSize = 6;

  /// 一条完整帧的最大长度（防止畸形长度导致的内存爆炸）。
  static const int maxPayload = 8 * 1024 * 1024;

  Uint8List encode() {
    final out = Uint8List(headerSize + payload.length);
    final view = ByteData.view(out.buffer);
    view.setUint16(0, type, Endian.big);
    view.setUint32(2, payload.length, Endian.big);
    out.setRange(headerSize, headerSize + payload.length, payload);
    return out;
  }

  /// 从缓冲区里尽可能多地解析帧。
  ///
  /// 返回解析出的帧列表与尚未消费的剩余字节。调用方应把剩余字节
  /// 拼到下一次读取的数据前面再继续解析（TCP 是字节流，不保证帧对齐）。
  static (List<ControlFrame>, Uint8List) decodeAll(Uint8List buffer) {
    final frames = <ControlFrame>[];
    var offset = 0;

    while (buffer.length - offset >= headerSize) {
      final view = ByteData.sublistView(buffer, offset);
      final type = view.getUint16(0, Endian.big);
      final length = view.getUint32(2, Endian.big);

      if (length > maxPayload) {
        throw FormatException('ControlFrame: 载荷长度异常 $length');
      }
      if (buffer.length - offset - headerSize < length) {
        break; // 还没收全
      }

      final start = offset + headerSize;
      frames.add(ControlFrame(
        type,
        Uint8List.fromList(buffer.sublist(start, start + length)),
      ));
      offset = start + length;
    }

    return (frames, Uint8List.fromList(buffer.sublist(offset)));
  }

  @override
  String toString() => 'ControlFrame(type=$type, len=${payload.length})';
}

/// Mumble 控制通道的消息类型（`Mumble.proto` 之外的 2 字节前缀）。
abstract final class MessageType {
  static const int version = 0;
  static const int udpTunnel = 1;
  static const int authenticate = 2;
  static const int ping = 3;
  static const int reject = 4;
  static const int serverSync = 5;
  static const int channelRemove = 6;
  static const int channelState = 7;
  static const int userRemove = 8;
  static const int userState = 9;
  static const int banList = 10;
  static const int textMessage = 11;
  static const int permissionDenied = 12;
  static const int acl = 13;
  static const int queryUsers = 14;
  static const int cryptSetup = 15;
  static const int contextActionModify = 16;
  static const int contextAction = 17;
  static const int userList = 18;
  static const int voiceTarget = 19;
  static const int permissionQuery = 20;
  static const int codecVersion = 21;
  static const int userStats = 22;
  static const int requestBlob = 23;
  static const int serverConfig = 24;
  static const int suggestConfig = 25;

  /// 1.5+：扩展侧信道，原版客户端忽略。
  static const int pluginDataTransmission = 26;

  static const Map<int, String> names = {
    version: 'Version',
    udpTunnel: 'UDPTunnel',
    authenticate: 'Authenticate',
    ping: 'Ping',
    reject: 'Reject',
    serverSync: 'ServerSync',
    channelRemove: 'ChannelRemove',
    channelState: 'ChannelState',
    userRemove: 'UserRemove',
    userState: 'UserState',
    banList: 'BanList',
    textMessage: 'TextMessage',
    permissionDenied: 'PermissionDenied',
    acl: 'ACL',
    queryUsers: 'QueryUsers',
    cryptSetup: 'CryptSetup',
    contextActionModify: 'ContextActionModify',
    contextAction: 'ContextAction',
    userList: 'UserList',
    voiceTarget: 'VoiceTarget',
    permissionQuery: 'PermissionQuery',
    codecVersion: 'CodecVersion',
    userStats: 'UserStats',
    requestBlob: 'RequestBlob',
    serverConfig: 'ServerConfig',
    suggestConfig: 'SuggestConfig',
    pluginDataTransmission: 'PluginDataTransmission',
  };

  static String nameOf(int type) => names[type] ?? 'Unknown($type)';
}
