/// Mumble 自定义变长整数（varint）编解码。
///
/// 等价于官方 `src/PacketDataStream.h` 里 `quint64` 的 `operator<<` / `operator>>`。
/// **注意：这不是 protobuf 的 varint。** 负数用"取反"编码，与补码无关。
///
/// 编码表（来自官方 docs/dev/network-protocol/voice_data.md）：
///
/// | 编码前缀                    | 解码结果              |
/// |-----------------------------|-----------------------|
/// | `0xxxxxxx`                  | 7 位正数              |
/// | `10xxxxxx` + 1B             | 14 位                 |
/// | `110xxxxx` + 2B             | 21 位                 |
/// | `1110xxxx` + 3B             | 28 位                 |
/// | `111100__` + 4B             | 32 位                 |
/// | `111101__` + 8B             | 64 位                 |
/// | `111110__` + varint         | 负数递归              |
/// | `111111xx`                  | `~(xx)` 的负数        |
library;

import 'dart:typed_data';

/// 读写 Mumble varint 的字节流。
///
/// 写入从尾部追加，读取从头部消费；两者可以混用（例如先写头再读）。
class PacketDataStream {
  final List<int> _data;
  int _pos;

  /// 创建一个空流（写入用）。
  PacketDataStream() : _data = <int>[], _pos = 0;

  /// 从已有字节创建一个流（读取用）。
  PacketDataStream.fromBytes(List<int> bytes)
      : _data = List<int>.of(bytes),
        _pos = 0;

  int get length => _data.length;
  int get position => _pos;
  int get remaining => _data.length - _pos;
  bool get isEmpty => remaining <= 0;

  /// 当前已写入/已消费的字节。
  Uint8List toBytes() => Uint8List.fromList(_data);

  /// 只返回未消费的剩余字节。
  Uint8List rest() => Uint8List.fromList(_data.sublist(_pos));

  // ---------------------------------------------------------------------------
  // 基础字节
  // ---------------------------------------------------------------------------

  void writeByte(int b) => _data.add(b & 0xFF);

  int readByte() {
    if (_pos >= _data.length) {
      throw const FormatException('PacketDataStream: 读取越界');
    }
    return _data[_pos++];
  }

  void writeBytes(List<int> bytes) => _data.addAll(bytes);

  Uint8List readBytes(int count) {
    if (remaining < count) {
      throw FormatException(
        'PacketDataStream: 需要 $count 字节，只剩 $remaining',
      );
    }
    final out = Uint8List.fromList(_data.sublist(_pos, _pos + count));
    _pos += count;
    return out;
  }

  // ---------------------------------------------------------------------------
  // varint
  // ---------------------------------------------------------------------------

  /// 写入一个 varint。
  ///
  /// 官方实现（`PacketDataStream::operator<<`）的负数判定是：
  /// 最高位为 1 **且** `~i < 2^32`（即高 32 位全为 1，值域 `[-2^32, -1]`）。
  /// 超出这个范围的负数会被当成无符号 64 位数，走 8 字节分支。
  void writeVarint(int value) {
    var i = value;

    final isNegative = (i & _bit63) != 0 && (~i < 0x100000000);
    if (isNegative) {
      i = ~i;
      if (i <= 0x3) {
        // 111111xx：~(xx) 的负数，覆盖 -1..-4
        writeByte(0xFC | i);
        return;
      }
      // 111110__：负数递归
      writeByte(0xF8);
    }

    // 官方实现里 i 是 quint64（无符号），所以这里必须用无符号比较：
    // 最高位为 1 的值在无符号语义下一定 >= 2^63，不可能落进小分支。
    if (_uLess(i, 0x80)) {
      writeByte(i);
    } else if (_uLess(i, 0x4000)) {
      writeByte(0x80 | (i >> 8));
      writeByte(i & 0xFF);
    } else if (_uLess(i, 0x200000)) {
      writeByte(0xC0 | (i >> 16));
      writeByte((i >> 8) & 0xFF);
      writeByte(i & 0xFF);
    } else if (_uLess(i, 0x10000000)) {
      writeByte(0xE0 | (i >> 24));
      writeByte((i >> 16) & 0xFF);
      writeByte((i >> 8) & 0xFF);
      writeByte(i & 0xFF);
    } else if (_uLess(i, 0x100000000)) {
      writeByte(0xF0);
      writeByte((i >> 24) & 0xFF);
      writeByte((i >> 16) & 0xFF);
      writeByte((i >> 8) & 0xFF);
      writeByte(i & 0xFF);
    } else {
      writeByte(0xF4);
      for (var shift = 56; shift >= 0; shift -= 8) {
        writeByte((i >> shift) & 0xFF);
      }
    }
  }

  /// 无符号比较：`v` 的最高位为 1 时它 >= 2^63，必定不小于任何 [threshold]。
  static bool _uLess(int v, int threshold) => (v & _bit63) == 0 && v < threshold;


  /// 读取一个 varint。
  ///
  /// [depth] 是内部递归深度，用于防御畸形数据（官方限制为 8 层）。
  int readVarint([int depth = 0]) {
    final i = readByte();

    if ((i & 0x80) == 0x00) {
      return i & 0x7F;
    }
    if ((i & 0xC0) == 0x80) {
      return ((i & 0x3F) << 8) | readByte();
    }
    if ((i & 0xE0) == 0xC0) {
      return ((i & 0x1F) << 16) | (readByte() << 8) | readByte();
    }
    if ((i & 0xF0) == 0xE0) {
      return ((i & 0x0F) << 24) |
          (readByte() << 16) |
          (readByte() << 8) |
          readByte();
    }

    switch (i & 0xFC) {
      case 0xF0: // 32 位
        return (readByte() << 24) |
            (readByte() << 16) |
            (readByte() << 8) |
            readByte();
      case 0xF4: // 64 位
        var v = 0;
        for (var k = 0; k < 8; k++) {
          v = (v << 8) | readByte();
        }
        return v;
      case 0xF8: // 负数递归
        if (depth >= 8) {
          throw const FormatException('PacketDataStream: varint 递归过深');
        }
        return ~readVarint(depth + 1);
      case 0xFC: // ~(xx)
        return ~(i & 0x03);
      default:
        throw FormatException(
            'PacketDataStream: 非法的 varint 前缀 0x${i.toRadixString(16)}');
    }
  }

  static const int _bit63 = 0x8000000000000000;
}

/// Opus 帧长度头：低 13 位是长度，bit14 是终止位。
///
/// 见官方文档 voice_data.md 的 "Opus audio frames"。
class OpusLengthHeader {
  const OpusLengthHeader({required this.length, required this.isTerminator})
      : assert(length >= 0 && length <= 0x1FFF, 'Opus 帧长必须在 0..8191');

  final int length;
  final bool isTerminator;

  static const int maxLength = 0x1FFF;
  static const int terminatorBit = 0x2000;

  /// 编码成 varint 值（还未写成字节）。
  int get value => (length & maxLength) | (isTerminator ? terminatorBit : 0);

  /// 从 varint 值解码。
  factory OpusLengthHeader.decode(int raw) => OpusLengthHeader(
        length: raw & maxLength,
        isTerminator: (raw & terminatorBit) != 0,
      );

  @override
  String toString() =>
      'OpusLengthHeader(len=$length, terminator=$isTerminator)';
}
