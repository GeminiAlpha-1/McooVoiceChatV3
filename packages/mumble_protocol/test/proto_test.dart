import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:mumble_protocol/mumble_protocol.dart';
import 'package:mumble_protocol/mumble_udp.dart' as udp;
import 'package:test/test.dart';

void main() {
  test('Version 序列化往返', () {
    final version = Version(
      versionV1: 0x01050000,
      release: 'McooVoice 0.1.0',
      os: 'Windows',
      osVersion: '11',
    );

    final bytes = version.writeToBuffer();
    expect(bytes, isNotEmpty);

    final back = Version.fromBuffer(bytes);
    expect(back.versionV1, equals(0x01050000));
    expect(back.release, equals('McooVoice 0.1.0'));
    expect(back.os, equals('Windows'));
    expect(back.osVersion, equals('11'));
  });

  test('UserState 只写设置过的字段（proto2 语义）', () {
    final state = UserState(session: 42, selfMute: true);
    final back = UserState.fromBuffer(state.writeToBuffer());

    expect(back.session, equals(42));
    expect(back.selfMute, isTrue);
    expect(back.hasName(), isFalse, reason: '没设置的字段不应出现');
    expect(back.hasChannelId(), isFalse);
  });

  test('TextMessage 往返中文', () {
    final msg = TextMessage(
      actor: 7,
      message: '去拿快递了，20 分钟回来',
      session: [1, 2, 3],
    );
    final back = TextMessage.fromBuffer(msg.writeToBuffer());

    expect(back.message, equals('去拿快递了，20 分钟回来'));
    expect(back.session, equals([1, 2, 3]));
  });

  test('CryptSetup 的二进制字段保持原样', () {
    final key = Uint8List.fromList(List<int>.generate(16, (i) => i));
    final nonce = Uint8List.fromList(List<int>.generate(16, (i) => 255 - i));

    final back = CryptSetup.fromBuffer(
      CryptSetup(key: key, clientNonce: nonce).writeToBuffer(),
    );

    expect(back.key, equals(key));
    expect(back.clientNonce, equals(nonce));
  });

  test('语音通道的 Audio 消息与控制通道互不干扰', () {
    final audio = udp.Audio(
      target: 0,
      frameNumber: Int64(1234),
      opusData: Uint8List.fromList([1, 2, 3, 4]),
      isTerminator: false,
    );

    final back = udp.Audio.fromBuffer(audio.writeToBuffer());
    expect(back.target, equals(0));
    expect(back.frameNumber, equals(Int64(1234)));
    expect(back.opusData, equals([1, 2, 3, 4]));
    expect(back.isTerminator, isFalse);
  });

  test('protobuf 载荷能装进 ControlFrame 再取出来', () {
    final version = Version(versionV1: 0x01050000, release: 'test');
    final frame = ControlFrame(
      MessageType.version,
      Uint8List.fromList(version.writeToBuffer()),
    );

    final (frames, rest) = ControlFrame.decodeAll(frame.encode());
    expect(rest, isEmpty);
    expect(frames, hasLength(1));

    final decoded = Version.fromBuffer(frames.single.payload);
    expect(decoded.versionV1, equals(0x01050000));
    expect(decoded.release, equals('test'));
  });

  test('PluginDataTransmission 能承载扩展数据（1.5 侧信道）', () {
    final msg = PluginDataTransmission(
      senderSession: 3,
      data: Uint8List.fromList('{"type":"mcoo.presence"}'.codeUnits),
    );

    final back = PluginDataTransmission.fromBuffer(msg.writeToBuffer());
    expect(back.senderSession, equals(3));
    expect(
      String.fromCharCodes(back.data),
      equals('{"type":"mcoo.presence"}'),
    );
  });
}
