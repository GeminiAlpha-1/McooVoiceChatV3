import 'dart:typed_data';

import 'package:mumble_protocol/mumble_protocol.dart';
import 'package:test/test.dart';

List<int> encode(int value) {
  final stream = PacketDataStream()..writeVarint(value);
  return stream.toBytes();
}

int decode(List<int> bytes) =>
    PacketDataStream.fromBytes(bytes).readVarint();

void main() {
  group('varint 已知字节序列（对照官方 PacketDataStream）', () {
    const cases = <int, List<int>>{
      0x00: [0x00],
      0x01: [0x01],
      0x7F: [0x7F],
      0x80: [0x80, 0x80],
      0x3FFF: [0xBF, 0xFF],
      0x4000: [0xC0, 0x40, 0x00],
      0x1FFFFF: [0xDF, 0xFF, 0xFF],
      0x200000: [0xE0, 0x20, 0x00, 0x00],
      0x0FFFFFFF: [0xEF, 0xFF, 0xFF, 0xFF],
      0x10000000: [0xF0, 0x10, 0x00, 0x00, 0x00],
      0xFFFFFFFF: [0xF0, 0xFF, 0xFF, 0xFF, 0xFF],
      0x100000000: [0xF4, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00],
    };

    cases.forEach((value, expected) {
      test('0x${value.toRadixString(16)} 编码', () {
        expect(encode(value), equals(expected));
      });
      test('0x${value.toRadixString(16)} 解码', () {
        expect(decode(expected), equals(value));
      });
    });
  });

  group('varint 负数（取反编码，不是补码）', () {
    const cases = <int, List<int>>{
      -1: [0xFC],
      -2: [0xFD],
      -3: [0xFE],
      -4: [0xFF],
      -5: [0xF8, 0x04],
      // 官方负数分支只覆盖 [-2^32, -1]；更小的负数走 64 位无符号分支。
      -4294967297: [0xF4, 0xFF, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF],
    };

    cases.forEach((value, expected) {
      test('$value 编码', () => expect(encode(value), equals(expected)));
      test('$value 解码', () => expect(decode(expected), equals(value)));
    });
  });

  group('varint 往返', () {
    final values = <int>[
      0, 1, 2, 63, 64, 127, 128, 255, 256,
      16383, 16384, 65535, 65536,
      2097151, 2097152, 1 << 24, (1 << 28) - 1, 1 << 28,
      0xFFFFFFFF, 1 << 32, 1 << 40, 1 << 50, 1 << 62,
      -1, -2, -3, -4, -5, -63, -64, -127, -128,
      -1000, -65536, -(1 << 20), -(1 << 40),
    ];

    for (final value in values) {
      test('$value 往返一致', () {
        expect(decode(encode(value)), equals(value));
      });
    }
  });

  test('连续写入多个 varint 后按序读出', () {
    final stream = PacketDataStream()
      ..writeVarint(1)
      ..writeVarint(300)
      ..writeVarint(-7)
      ..writeVarint(1 << 40);

    final reader = PacketDataStream.fromBytes(stream.toBytes());
    expect(reader.readVarint(), equals(1));
    expect(reader.readVarint(), equals(300));
    expect(reader.readVarint(), equals(-7));
    expect(reader.readVarint(), equals(1 << 40));
    expect(reader.remaining, equals(0));
  });

  test('读取越界抛 FormatException', () {
    final reader = PacketDataStream.fromBytes([0x80]);
    expect(() => reader.readVarint(), throwsA(isA<FormatException>()));
  });

  group('Opus 帧长度头', () {
    test('长度与终止位往返', () {
      const header = OpusLengthHeader(length: 1234, isTerminator: true);
      expect(header.value, equals(1234 | 0x2000));

      final back = OpusLengthHeader.decode(header.value);
      expect(back.length, equals(1234));
      expect(back.isTerminator, isTrue);
    });

    test('终止位不影响长度解析', () {
      final back = OpusLengthHeader.decode(0x1FFF | 0x2000);
      expect(back.length, equals(0x1FFF));
      expect(back.isTerminator, isTrue);
    });

    test('超长长度断言失败', () {
      expect(() => OpusLengthHeader(length: 0x2000, isTerminator: false),
          throwsA(isA<AssertionError>()));
    });
  });

  group('ControlFrame 分帧', () {
    test('编码后能原样解出', () {
      final payload = Uint8List.fromList([1, 2, 3, 4, 5]);
      final frame = ControlFrame(MessageType.userState, payload);
      final bytes = frame.encode();

      expect(bytes.length, equals(ControlFrame.headerSize + payload.length));
      expect(bytes[0], equals(0x00));
      expect(bytes[1], equals(0x09)); // UserState = 9
      expect(bytes[2], equals(0x00));
      expect(bytes[3], equals(0x00));
      expect(bytes[4], equals(0x00));
      expect(bytes[5], equals(0x05));

      final (frames, rest) = ControlFrame.decodeAll(bytes);
      expect(frames, hasLength(1));
      expect(frames.single.type, equals(MessageType.userState));
      expect(frames.single.payload, equals(payload));
      expect(rest, isEmpty);
    });

    test('半包时不产出帧，剩余字节保留', () {
      final bytes = ControlFrame(MessageType.ping, Uint8List.fromList([9, 9]))
          .encode();
      final partial = Uint8List.sublistView(bytes, 0, bytes.length - 1);

      final (frames, rest) = ControlFrame.decodeAll(partial);
      expect(frames, isEmpty);
      expect(rest, equals(partial));
    });

    test('粘包时一次解出多帧', () {
      final a = ControlFrame(MessageType.version, Uint8List.fromList([1]))
          .encode();
      final b = ControlFrame(MessageType.ping, Uint8List.fromList([2, 3]))
          .encode();

      final merged = Uint8List.fromList([...a, ...b]);
      final (frames, rest) = ControlFrame.decodeAll(merged);

      expect(frames, hasLength(2));
      expect(frames[0].type, equals(MessageType.version));
      expect(frames[1].type, equals(MessageType.ping));
      expect(frames[1].payload, equals([2, 3]));
      expect(rest, isEmpty);
    });

    test('载荷长度异常时抛错（防内存爆炸）', () {
      final bogus = Uint8List.fromList([
        0x00, 0x03, // Ping
        0xFF, 0xFF, 0xFF, 0xFF, // 长度 4GB
      ]);
      expect(() => ControlFrame.decodeAll(bogus),
          throwsA(isA<FormatException>()));
    });

    test('UDPTunnel 类型的载荷按原样保留（不是 protobuf）', () {
      final raw = Uint8List.fromList([0x80, 0x01, 0x02]);
      final bytes = ControlFrame(MessageType.udpTunnel, raw).encode();
      final (frames, _) = ControlFrame.decodeAll(bytes);
      expect(frames.single.payload, equals(raw));
    });
  });
}
