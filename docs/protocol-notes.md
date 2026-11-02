# Mumble 协议速查（实现时对照用）

> 来源：官方 `docs/dev/network-protocol/*`、`src/Mumble.proto`、`src/MumbleUDP.proto`（BSD-3）。
> 核对日期：2026-11-02。**以 proto 文件为最终事实来源**，本文只做索引与踩坑提示。

---

## 1. 控制通道（TCP + TLS）

```
[2B 消息类型, big-endian][4B 载荷长度, big-endian][载荷]
```

| 类型 | 消息 | 备注 |
|---|---|---|
| 0 | Version | 握手第一步，交换版本与能力位 |
| 1 | **UDPTunnel** | **载荷是裸语音包，不是 protobuf**——解析时不能走 protobuf 解码 |
| 2 | Authenticate | 用户名/密码/证书/tokens |
| 3 | Ping | 心跳，也用于统计延迟 |
| 4 | Reject | 拒绝连接（原因 + 重定向） |
| 5 | ServerSync | 握手完成，给出自身 session 与服务器配置 |
| 6 | ChannelRemove | |
| 7 | ChannelState | 增量：新建/改名/移动/链接 |
| 8 | UserRemove | 断开/踢出/封禁 |
| 9 | UserState | 增量：改名/换频道/静音等 |
| 10 | BanList | |
| 11 | TextMessage | 频道/用户/树 |
| 12 | PermissionDenied | |
| 13 | ACL | |
| 14 | QueryUsers | 名字 ↔ session 映射 |
| 15 | CryptSetup | UDP 加密密钥/ nonce |
| 16 | ContextActionModify | 右键菜单项（服务端/插件提供） |
| 17 | ContextAction | 右键菜单点击 |
| 18 | UserList | 注册用户列表 |
| 19 | VoiceTarget | 注册 whisper 目标 |
| 20 | PermissionQuery | 权限位缓存 |
| 21 | CodecVersion | 服务器裁决编解码器 |
| 22 | UserStats | 统计（在线/空闲/证书/带宽） |
| 23 | RequestBlob | 批量拉取头像/评论 |
| 24 | ServerConfig | |
| 25 | SuggestConfig | |
| 26 | **PluginDataTransmission** | 1.5+，扩展侧信道（我们要用的） |

**握手顺序**：`Version → Authenticate → (CryptSetup) → ServerSync → 快照（ChannelState/UserState 若干）`。

---

## 2. 语音包

### 2.1 头字节

```
bit 7-5: 类型     bit 4-0: target
```

| 类型 | 值 | 说明 |
|---|---|---|
| CELT Alpha | 0 | 历史，不实现 |
| Ping | 1 | 头字节固定 `0x20` |
| Speex | 2 | 历史，不实现 |
| CELT Beta | 3 | 历史，不实现 |
| Opus | 4 | 现代唯一需要实现的 |

target：`0` 普通，`1–30` whisper，`31` 服务器回环。

### 2.2 1.4 及以前（裸包）

```
[1B 头][varint session(仅下行)][varint seq][varint len | 0x2000 终止位][opus bytes][可选 float32 x3 位置]
```

- 上行包**不含 session**（服务器按连接识别），下行包**含 session**。
- `len` 的 bit14（`0x2000`）= 终止位，表示这是本次发言的最后一帧。
- 整包 ≤ 1020 字节。

### 2.3 1.5+（protobuf UDP）

用 `MumbleUDP.Audio` / `MumbleUDP.Ping`。关键字段：

- `target`（上行）/ `context`（下行）
- `sender_session`
- `frame_number`（uint64，帧序号，替代 seq）
- `opus_data`
- `positional_data`（repeated float）
- `is_terminator`

> 实现上做成策略：`VoiceCodec14` / `VoiceCodec15`，按握手拿到的服务器版本选择。

---

## 3. 加密

| 通道 | 加密 |
|---|---|
| TCP | 整条连接 TLS |
| UDP | OCB-AES128，密钥与 nonce 来自 `CryptSetup` |

`CryptSetup` 三个字段：`key`（16B）、`client_nonce`（16B）、`server_nonce`（16B）。收发各自递增 nonce，需要**重放保护窗口**（建议 64 位滑动窗口）。

> 实现提示：OCB 不是常见 AEAD，`pointycastle` 没有现成实现。要么自己写（有 RFC 7253 测试向量可验证），要么移植 dumble 的 Dart 实现（BSD-2，需保留版权声明）。**先用测试向量锁死正确性再接入链路。**

---

## 4. varint

Mumble 自定义，不是 protobuf 的 varint：

| 编码前缀 | 解码结果 |
|---|---|
| `0xxxxxxx` | 7 位正数 |
| `10xxxxxx` + 1B | 14 位 |
| `110xxxxx` + 2B | 21 位 |
| `1110xxxx` + 3B | 28 位 |
| `111100__` + 4B | 32 位 |
| `111101__` + 8B | 64 位 |
| `111110__` + varint | 负数递归 |
| `111111xx` | `~xx` 的负数（2 位取反） |

> 官方实现参考 `src/PacketDataStream.h` 的 `quint64` 位移运算符。
> **踩坑**：负数用"取反的 2 位负数"编码，别直接用补码，否则坐标与部分字段会解错。

---

## 5. 连接韧性

- UDP 起手先发 `Ping`，收到回显才启用 UDP；此后持续 ping。
- UDP 连续失败 → 语音改走 `UDPTunnel`（TCP），但**继续 ping**，恢复后切回。
- 服务器也可以主动把出站切回 TCP，客户端需同时支持双向切换。

---

## 6. 权限与 ACL（易错点）

- 权限位是 64 位掩码，`PermissionQuery` 缓存到频道，用户权限 = 自身 + 继承自父频道 + 组。
- `SuperUser` 绕过所有 ACL。
- 移动用户需要 `Move` 权限**且在目标频道有 `Enter`**——AFK bot 常在这里失败。
- 临时频道（`temporary`）在最后一人离开后由服务器删除。

---

## 7. 兼容性矩阵（我们的目标）

| 服务器版本 | 支持程度 |
|---|---|
| 1.4.x | 完整（语音走裸包） |
| 1.5.x | 完整（语音走 protobuf UDP，扩展侧信道可用） |
| 1.3 及更早 | 尽力（不保证 Opus，可能只有 CELT/Speex → 只收不发或提示降级） |

---

## 8. 参考实现（仅作思路参考，注意许可）

| 项目 | 语言 | 许可 | 用途 |
|---|---|---|---|
| [mumble-voip/mumble](https://github.com/mumble-voip/mumble) | C++/Qt | BSD-3 | proto 文件、协议文档、行为基准 |
| [EPNW/dumble](https://github.com/EPNW/dumble) | Dart | BSD-2 | varint / OCB / 状态机的参考实现，可移植片段 |
| [quite/humla](https://github.com/quite/humla) | Java | GPL-3 | Android 音频与协议分层思路，**不可抄代码** |
| [Mumcord/mumcord](https://github.com/Mumcord/mumcord) | Rust/TS | AGPL-3 | 架构与产品思路，**不可抄代码** |
| [GDur/rumble-voip](https://github.com/GDur/rumble-voip) | Flutter | — | Flutter 双端可行性的实证 |
