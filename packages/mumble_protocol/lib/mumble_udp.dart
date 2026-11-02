/// Mumble **语音通道**（UDP）的 protobuf 消息（`MumbleUDP`）。
///
/// 只在 Mumble 1.5+ 使用：1.4 及以前是手写的裸包格式，见 `voice_packet.dart`。
///
/// 单独一个入口，是因为这里的 `Ping` / `Audio` 与控制通道的同名消息冲突。
library;

export 'src/proto/MumbleUDP.pb.dart';
