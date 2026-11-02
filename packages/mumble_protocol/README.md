# mumble_protocol

Mumble 协议编解码与传输。**纯 Dart**，零 Flutter 依赖，客户端与 `mcoo-service` 共用。

## 入口

| 文件 | 内容 | 说明 |
|---|---|---|
| `package:mumble_protocol/mumble_protocol.dart` | 控制通道消息（`MumbleProto`）+ 分帧 + varint | 日常用这个 |
| `package:mumble_protocol/mumble_udp.dart` | 语音通道消息（`MumbleUDP`，1.5+） | 两边的 `Ping`/`Audio` 同名，分开入口避免冲突 |

## 已完成

- ✅ `PacketDataStream`：Mumble 自定义 varint（含负数取反编码、无符号比较语义、递归深度保护）
- ✅ `ControlFrame`：TCP `[2B type][4B len][payload]` 分帧，处理半包/粘包/畸形长度
- ✅ `MessageType`：0–26 的消息类型常量（含 1.5 的 `PluginDataTransmission`）
- ✅ 官方 `Mumble.proto` / `MumbleUDP.proto` vendor + 生成的 Dart 类

## 待办

- ⬜ 语音包编解码（1.4 裸包 + 1.5 protobuf）
- ⬜ OCB-AES128 加解密 + 重放窗口
- ⬜ TCP/TLS 传输、UDP 传输、内存传输（测试用）
- ⬜ 握手状态机（Version → Authenticate → ServerSync）
- ⬜ 频道树/用户表增量状态机
- ⬜ golden 抓包回归测试

## 生成 protobuf 代码

见 [proto/README.md](proto/README.md)。

**坑**：`protoc_plugin` 的版本与运行时 `protobuf` 包必须匹配。当前组合是
`protoc 36.2` + `protoc_plugin 25.1.0` + `protobuf ^6.1.0`。
不匹配时的报错长这样（完全没提版本问题，很容易误判成代码生成坏了）：

```
error - lib/src/proto/Mumble.pb.dart: The method 'aI' isn't defined for the type 'BuilderInfo'
error - lib/src/proto/Mumble.pb.dart: The argument type 'GeneratedMessage Function()' can't be assigned to the parameter type 'Audio Function()'
```

## 测试

```bash
dart test          # 89 个用例，不需要任何设备或网络
```

测试覆盖的是**协议正确性**（字节级），不是集成——集成测试在 M1 后半段用真实服务器做。
