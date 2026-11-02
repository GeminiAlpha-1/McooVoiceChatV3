/// Mumble 协议编解码与传输。
///
/// 这个包是**纯 Dart** 的：不依赖 Flutter、不碰音频设备、不做 IO 策略。
/// 客户端与 `mcoo-service` 共用同一份实现。
///
/// 这里导出的是**控制通道**用到的消息类（`MumbleProto`）。
/// 语音通道的 protobuf 消息在 `mumble_udp.dart` 里——两边的 `Ping`
/// 同名但结构不同，分成两个入口避免冲突。
library;

export 'src/proto/Mumble.pb.dart';
export 'src/proto/Mumble.pbenum.dart';
export 'src/session/server_state.dart';
export 'src/session/session.dart';
export 'src/transport/transport.dart';
export 'src/wire/frame.dart';
export 'src/wire/varint.dart';
