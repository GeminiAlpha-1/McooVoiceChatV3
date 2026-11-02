# McooVoiceChat V3 总体架构

> 目标：保留 Mumble 的协议语义与语音品质，重做一套 TeamSpeak 风格的现代化 UI，并在双端（Windows 便携包 / Android）上可插件化扩展。

- 相关决策：[ADR-0001 技术栈](adr/0001-client-stack.md) · [ADR-0002 服务端策略](adr/0002-server-strategy.md) · [ADR-0003 插件模型](adr/0003-plugin-model.md) · [ADR-0004 协议层](adr/0004-protocol.md)

---

## 1. 分层

```
┌───────────────────────────────────────────────────────────────┐
│  App Shell                                                     │
│  窗口 / 路由 / 主题 / 托盘 / 全局快捷键 / 便携模式 / 崩溃上报      │
├───────────────────────────────────────────────────────────────┤
│  UI Layer（纯展示，不碰 IO）                                    │
│  频道树 · 用户列表 · 聊天 · 点歌台 · 设置 · 状态栏 · Dock        │
├───────────────────────────────────────────────────────────────┤
│  Plugin Host                                                   │
│  槽位注册 · 能力授权 · 生命周期 · L2 解释器 · L3 WS 桥           │
├───────────────────────────────────────────────────────────────┤
│  Application（用例编排，无 UI 依赖）                             │
│  SessionController · AfkService · JukeboxService · ChatService │
├───────────────────────────────────────────────────────────────┤
│  Domain（纯 Dart 模型 + 不变量，零 IO）                          │
│  Channel / User / Session / VoiceTarget / Acl / Permission     │
├───────────────────────────────────────────────────────────────┤
│  Ports（抽象接口，只开在真实边界上）                              │
│  ITransport · ICodec · IAudioDevice · ISecureStore · IClock    │
├───────────────────────────────────────────────────────────────┤
│  Adapters                                                      │
│  TcpTlsTransport · UdpTransport · OpusCodec(FFI)               │
│  MiniaudioDevice(FFI) · SqliteStore · KeychainStore             │
└───────────────────────────────────────────────────────────────┘
```

**依赖方向严格向下**。UI 不认识 `dart:io`，Domain 不认识 Flutter，Adapters 只在 `main()` 里组装。

---

## 2. 抽象层的取舍（回答"中间抽象层是否必要"）

结论：**必要，但只在四处；其余地方一律用具体类。**

### 该加接口的地方（有真实替换/测试需求）

| Port | 为什么必须抽象 | 现有实现 | 第二个实现从哪来 |
|---|---|---|---|
| `ITransport` | TCP/UDP/隧道三种路径，且测试要内存传输 | TcpTls / Udp / Tunnel | `MemoryTransport`（测试） |
| `IAudioDevice` | Windows(WASAPI) 与 Android(AAudio/OpenSL) 差异极大；CI 无音频设备 | MiniaudioDevice | `NullAudioDevice`（测试/CI） |
| `ICodec` | Opus 是唯一真实实现，但**测试与无设备环境**必须能跑通链路 | OpusCodec | `PassthroughCodec`（测试） |
| `IStore` | 桌面文件 vs Android 私有目录 + 安全存储 | SqliteStore | `MemoryStore`（测试） |

### 不加接口的地方（加了就是负债）

- **Domain 模型**：`User` 就是个数据类，不需要 `IUser`。
- **每个 Service 一个 Factory + DI 容器**：构造函数注入足够，不做容器全家桶。
- **"以后可能换 UI 框架"**：不为此抽象。ADR-0001 已经锁定了 Flutter。
- **日志/时间/随机数**：只有 `IClock` 值得抽象（测试 AFK 定时器要用假时钟），其余直接调。

> v2 的 `module-helper.js` 已经把"生命周期 + 资源回收 + 渲染防抖"做对了，但它的 `ctx` 是个大杂烩对象（store/events/panel/audio/room/api/dock 全塞进去）。V3 改成**按需注入的窄接口**：插件要什么给什么，拿不到就用不了，权限面天然收窄。

---

## 3. 模块清单

| 路径 | 职责 | 依赖 | 可否独立测试 |
|---|---|---|---|
| `packages/mumble_protocol` | 协议编解码、TLS/UDP 传输、OCB、状态机 | 无（纯 Dart） | ✅ `dart test` |
| `packages/mcoo_audio` | Opus 编解码、抖动缓冲、混音、处理链 | `mcoo_native` | ✅ 用假设备 |
| `packages/mcoo_native` | C 源码（miniaudio/libopus/speexdsp）+ CMake | — | — |
| `packages/mcoo_core` | 会话编排、领域模型、AFK/点歌用例 | protocol, audio | ✅ |
| `packages/mcoo_plugin_api` | 插件契约、manifest 模型、能力枚举 | core | ✅ |
| `packages/mcoo_ui_kit` | 设计系统：主题、令牌、通用组件 | Flutter | widget test |
| `apps/client` | Flutter 应用壳 + UI + 插件宿主 | 以上全部 | 集成测试 |
| `apps/mcoo-service` | 常驻 bot：AFK + 点歌台 + 插件 | protocol, audio | ✅ |

---

## 4. 关键数据流

### 4.1 建立连接

```
UI 点击连接
  → SessionController.connect(profile)
    → TcpTlsTransport.connect(host, port)      # TLS，校验指纹
    → Version → Authenticate(password | cert) → CryptSetup
    → ServerSync（自身 session、服务器配置）
    → 拉取 ChannelState / UserState / PermissionQuery 快照，构建 Domain 图
    → UDP 连通性探测（Ping/Pong）；成功则启用 UDP，失败降级 TCP 隧道
    → 状态置 Connected，UI 收到一次完整快照
```

### 4.2 发送语音

```
按住 PTT（全局快捷键）
  → AudioPipeline.startCapture()
    → C: miniaudio 回调写环形缓冲
    → Dart: 每 10ms 取 480 samples(48k) → Opus encode(20ms 帧)
    → VoicePacket.encode(opus, seq, target)
    → UdpTransport.send(OCB 加密)  ──失败──→ TcpTunnel.send
```

### 4.3 接收语音

```
UDP recv → OCB 解密 → VoicePacket.decode
  → 抖动缓冲（按 seq 排序、丢包隐藏）
  → Opus decode → PCM
  → 混音器（多路相加 + 限幅 + 每用户音量）
  → C: 写播放环形缓冲 → 扬声器
  → 同时向 UI 发 `user:speaking` 事件（驱动音量条/高亮）
```

**注意**：UI 的"谁在说话"由音频层事件驱动，不由 UI 轮询——v2 在这块是靠 store 轮询，会有延迟。

### 4.4 AFK

```
McooService(AFK 模块) 每 5s:
  → 对每个在线用户取双源空闲时长（客户端上报 > UserStats.idlesecs）
  → idle > threshold 且不在 AFK 频道 → Move 到 AFK 频道，记录原频道
  → 活跃且记录存在 → Move 回原频道
  → 同一用户 30s 内不重复移动（防抖，避免和用户手动操作打架）
客户端:
  → 收到 UserState 变更 → 更新 Domain → UI 打 AFK 徽标 + 时长
```

### 4.5 点歌台

```
客户端 UI 搜索 → HTTP/WS 到 mcoo-service
  → 服务端队列（revision 单调递增，客户端按 revision 丢弃过期快照）
  → 当前曲目：ffmpeg 子进程解码 → PCM → 重采样 48k → Opus 96k 立体声
  → 以 bot 身份向频道发语音包（20ms 帧，实时时钟驱动）
客户端 UI 通过 WS 订阅队列与播放进度，只做展示与操作
```

---

## 5. 状态管理

- **`flutter_riverpod`**：编译期安全的依赖注入 + 作用域生命周期，且 provider 可脱离 Widget 树单测。
- 分层约定：
  - `Provider`（只读依赖：transport/audio/store 实例）
  - `Notifier`（可变的会话状态：当前频道、用户表）
  - `StreamProvider`（音频事件、网络事件）
- **禁止**：UI 直接调用 `Transport`；一律经 `SessionController`。

> 与 v2 的差异：v2 用 `store.set(path)` + 字符串路径 + 全局事件总线，调试时很难追踪"谁改的"。V3 用类型化 Notifier，改状态必须过方法。

---

## 6. 错误与韧性

| 场景 | 策略 |
|---|---|
| 网络闪断 | 指数退避重连（1s→2s→4s→…→30s 封顶），保留频道/静音状态 |
| 证书变更 | 阻断并弹指纹对比，绝不静默接受 |
| 音频设备热插拔 | 监听设备变更，重建 C 侧设备但不丢会话 |
| 插件崩溃 | L1 错误边界隔离；L2/L3 进程外，宿主只标记该插件失效 |
| 原生崩溃 | 写 minidump 到数据目录，下次启动提示导出 |

---

## 7. 性能预算

| 指标 | 目标 |
|---|---|
| 冷启动到可连接 | ≤ 2.0 s（Windows）、≤ 3.0 s（中端 Android） |
| PTT 到对端出声（局域网） | ≤ 120 ms |
| 空闲内存 | ≤ 180 MB（Windows） |
| 语音期间 CPU | ≤ 5%（单核，i5-8250U 基准） |
| 便携包体积 | ≤ 60 MB（zip） |

超出预算时优先保音频路径，UI 可降级（关闭动画/减少重绘）。

---

## 8. 目录结构

```
McooVoiceChatV3/
├── apps/
│   ├── client/                 # Flutter 客户端
│   │   ├── lib/
│   │   │   ├── main.dart
│   │   │   ├── app/            # shell：窗口、路由、主题、托盘
│   │   │   ├── features/       # 按功能切：servers/channels/users/chat/jukebox/settings
│   │   │   ├── plugins/        # 插件宿主 + 内置插件
│   │   │   └── di.dart
│   │   ├── android/  windows/
│   │   └── test/
│   └── mcoo-service/           # 常驻 bot（AFK + 点歌台）
├── packages/
│   ├── mumble_protocol/
│   ├── mcoo_audio/
│   ├── mcoo_native/            # C 源码 + CMake
│   ├── mcoo_core/
│   ├── mcoo_plugin_api/
│   └── mcoo_ui_kit/
├── docs/
│   ├── adr/
│   ├── features/{afk,jukebox}.md
│   ├── architecture.md
│   ├── protocol-notes.md
│   └── roadmap.md
├── .github/workflows/
└── README.md
```

**为什么是 monorepo + path 依赖**：协议层与 bot 必须与客户端同版本演进；跨仓同步是单人项目的最大税。
