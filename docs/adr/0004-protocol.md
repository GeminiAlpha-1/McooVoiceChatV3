# ADR-0004 协议层：自研 Dart 实现，vendor 官方 proto，参考 dumble

- 状态：**Proposed**
- 日期：2026-11-02
- 影响范围：`packages/mumble_protocol`

## 1. 现状盘点

| 可复用物 | 语言 | 许可 | 状态 | 能否直接用 |
|---|---|---|---|---|
| Mumble 官方客户端代码 | C++/Qt | BSD-3 | 活跃 | ❌ 与 QtWidgets 深度耦合，抽不出独立核心 |
| `Mumble.proto` / `MumbleUDP.proto` | protobuf | BSD-3 | 活跃 | ✅ **vendor 进仓库** |
| [dumble](https://github.com/EPNW/dumble) | Dart | BSD-2 | 停更 ~5 年，覆盖 1.4 | ⚠️ 参考/局部移植 |
| [Humla](https://github.com/quite/humla) | Java | GPL-3 | 活跃（Mumla 的底层） | ❌ 语言与许可都不合 |
| [mumcord-protocol](https://crates.io/crates/mumcord-protocol) | Rust | AGPL-3 | 活跃 | ❌ 许可传染 |
| [mumble-protocol](https://crates.io/crates/mumble-protocol) (johni0702) | Rust | — | 停更 | ❌ 语言不合 |

**结论：自研。** 但把官方 proto 作为唯一事实来源，用 dumble 做交叉验证。

## 2. 协议要点（已核对官方文档，2026-11-02）

### 2.1 控制通道（TCP + TLS）

```
[2 字节 消息类型 BE][4 字节 长度 BE][protobuf 载荷]
```

消息类型 0–26，其中 `1 = UDPTunnel`（载荷是**裸语音包**，不是 protobuf）、`26 = PluginDataTransmission`（1.5+，我们的扩展侧信道）。

### 2.2 语音通道

包头 1 字节：高 3 位 = 类型，低 5 位 = target。

| 类型 | 值 | 说明 |
|---|---|---|
| CELT Alpha | 0 | 历史 |
| Ping | 1 | `0x20`，载荷为 varint 时间戳 |
| Speex | 2 | 历史 |
| CELT Beta | 3 | 历史 |
| **Opus** | **4** | 现代默认 |

target：`0` 普通说话，`1–30` whisper，`31` 服务器回环。

- **1.4 及以前**：Opus 帧 = `varint 长度`（bit14 为终止位）+ 数据；每包一个帧；整包 ≤ 1020 字节。
- **1.5+**：UDP 载荷改为 `MumbleUDP.Audio` protobuf（`frame_number`、`opus_data`、`is_terminator` 等），另有 `MumbleUDP.Ping`。
- **必须两种都实现**，按服务器版本协商选择。

### 2.3 加密

- TCP：整条连接 TLS。
- UDP：OCB-AES128，密钥来自控制通道的 `CryptSetup`（`key`/`client_nonce`/`server_nonce`），带重放窗口。
- UDP 不通时语音自动隧道到 TCP（`UDPTunnel`），并在后台持续 ping 以便恢复。

### 2.4 varint

Mumble 自定义变长整数，含**负数递归编码**与**按位取反的 2-bit 负数**。必须与官方 `PacketDataStream` 完全一致，否则包长解析会错位。

## 3. "保留核心业务逻辑"清单

重构 UI 不等于砍功能。以下语义必须在 v1 保留（可按优先级分批）：

- **频道**：树形父子、频道链接（links）、临时频道、频道密码、频道描述
- **权限**：ACL + 继承 + 组（groups）+ 权限位（Enter/Speak/MuteDeafen/Move/MakeChannel/…）
- **用户状态**：self_mute / self_deaf / server mute / server deaf / suppress / priority speaker / recording
- **语音目标**：普通 / whisper（频道、用户、shout）/ 服务器回环
- **认证**：密码 + 客户端证书（证书哈希即身份），支持记住服务器
- **编解码协商**：`CodecVersion` 由服务器裁决，客户端尊重
- **文本**：频道消息、私聊、树形消息
- **位置音频**：`plugin_context` / `plugin_identity` 透传（兼容官方游戏插件）
- **服务器配置**：欢迎语、最大带宽、最大用户数、允许录制
- **连接韧性**：断线重连、UDP↔TCP 隧道切换、Ping 统计（延迟/丢包/抖动）
- **统计**：`UserStats`（在线时长、空闲时长、证书、带宽）

## 4. 模块划分

```
packages/mumble_protocol/lib/
├── src/
│   ├── proto/            # protoc 生成（vendor 官方 .proto）
│   ├── wire/
│   │   ├── varint.dart   # PacketDataStream 等价实现
│   │   ├── frame.dart    # TCP 2+4 分帧
│   │   └── voice_packet.dart  # 1.4 / 1.5 两种语音包
│   ├── crypto/
│   │   └── ocb.dart      # OCB-AES128 + 重放窗口
│   ├── transport/
│   │   ├── tcp_transport.dart
│   │   ├── udp_transport.dart
│   │   └── memory_transport.dart  # 测试用
│   ├── session/
│   │   ├── handshake.dart      # Version → Authenticate → ServerSync
│   │   ├── state_machine.dart  # 频道树/用户表的增量应用
│   │   └── commands.dart       # 对外命令 API（join/move/text/…）
│   └── messages.dart
└── test/
    ├── varint_test.dart
    ├── voice_packet_test.dart
    └── golden/            # 抓包得到的真实字节，作为回归基准
```

## 5. 验证策略

1. **单元测试**：varint 边界值、语音包往返、OCB 加解密向量。
2. **Golden 抓包**：连真实服务器录一段字节流，离线重放，断言状态机结果。
3. **互操作测试**：与官方 Mumble 客户端同服对话（文本 + 语音），双向验证。
4. **CI**：纯 Dart 包，`dart test` 可在任意平台跑，不依赖 GUI。

## 6. 后果

- 正面：协议层是纯 Dart、零 GUI 依赖，可独立测试与复用（客户端、bot 共用一份）。
- 负面：1.5 的 protobuf UDP 与 1.4 的裸包双实现，代码量约 +40%；OCB 需自行实现并做向量验证。
