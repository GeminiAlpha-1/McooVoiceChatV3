# McooVoiceChat V3

基于 [Mumble](https://github.com/mumble-voip/mumble) 协议语义、重做 UI 的跨平台语音客户端。
保留 Mumble 的低延迟与协议兼容性，换上 TeamSpeak 风格的界面，并加入 **用户状态（去拿快递了 / 挂机中）**、**点歌台** 与 **稳定的账号身份**。

- 平台：**Windows（免安装便携包）** · **Android**
- 兼容：可直连任何标准 `mumble-server`（1.4 / 1.5），**无需改服务端**
- 扩展：三层插件模型，核心功能本身也以插件形式实现

> 前身是 [McooVoiceChat 2.0](../McooVoiceChat%202.0)（Electron + LiveKit）。V3 换了传输层（Mumble 协议）与客户端技术栈，但沿用了 2.0 的模块化思路、Dock 面板交互与点歌台视觉。

---

## 为什么不是"直接改 Mumble"

| 方案 | 问题 |
|---|---|
| Fork Mumble 换 UI | 客户端与 QtWidgets 深度耦合，等于重写；Android 无先例 |
| Fork murmur 加功能 | 服务端 C++/Qt + 数据库迁移，维护成本高，且失去与原版互通 |
| Electron 套壳 | Android 端只能 WebView，语音延迟与后台保活不可控 |

**结论**：重写客户端，协议语义照搬，服务端保持原版。详见 [ADR-0001](docs/adr/0001-client-stack.md) / [ADR-0002](docs/adr/0002-server-strategy.md)。

## 技术栈

| 层 | 选型 | 理由 |
|---|---|---|
| UI | Flutter | 一套代码双端；Windows 产物是纯文件夹，天然免安装 |
| 业务核心 | Dart | 与 UI 同语言，协议层可脱离 GUI 单测 |
| 实时音频 | C（miniaudio + libopus + speexdsp）经 FFI | 音频回调不进 Dart，GC 停顿碰不到音频线程 |
| 状态管理 | Riverpod | 编译期安全的 DI + 可脱离 Widget 树测试 |
| 常驻服务 | Dart CLI（`apps/mcoo-service`） | 只做点歌台的队列与时钟；默认不连 Mumble |

## 文档

| 文档 | 内容 |
|---|---|
| [architecture.md](docs/architecture.md) | 分层、模块职责、数据流、**抽象层该不该加**的判断标准 |
| [protocol-notes.md](docs/protocol-notes.md) | 协议速查：分帧、语音包、OCB、varint、权限坑 |
| [adr/0001](docs/adr/0001-client-stack.md) | 技术栈选型与 7 个候选的否决理由 |
| [adr/0002](docs/adr/0002-server-strategy.md) | 为什么不 fork murmur，扩展为什么放在客户端 |
| [adr/0003](docs/adr/0003-plugin-model.md) | 插件三层模型与能力授权 |
| [adr/0004](docs/adr/0004-protocol.md) | 协议层自研方案与"保留核心业务逻辑"清单 |
| [features/presence.md](docs/features/presence.md) | 用户状态：自定义文字、自动离开、跨客户端同步 |
| [features/jukebox.md](docs/features/jukebox.md) | 点歌台：本地播放优先，时钟同步与漂移校正 |
| [features/accounts.md](docs/features/accounts.md) | 账号系统：证书即身份，名字不可随意改 |
| [roadmap.md](docs/roadmap.md) | M0–M8 里程碑与验收标准 |

## 仓库结构

```
apps/
  client/          Flutter 客户端（Android + Windows）
  mcoo-service/    常驻 bot：AFK + 点歌台
packages/
  mumble_protocol/ 协议编解码 + 传输（纯 Dart，零 GUI 依赖）
  mcoo_audio/      Opus 编解码、抖动缓冲、混音
  mcoo_native/     C 源码（miniaudio/libopus/speexdsp）+ CMake
  mcoo_core/       领域模型 + 会话编排
  mcoo_plugin_api/ 插件契约
  mcoo_ui_kit/     设计系统
docs/              ADR、架构、功能设计、路线图
```

## 当前状态

**M0（决策与骨架）**。代码尚未开始，工具链未安装。下一步见 [roadmap.md](docs/roadmap.md)。

## 构建（工具链装好后）

```bash
# 一次性
#   Flutter SDK 3.2x+ / VS2022（Desktop development with C++）/ Android SDK + NDK / CMake / Ninja

dart pub get
cd apps/client && flutter pub get

# 单元测试（协议层不依赖 GUI）
dart test packages/mumble_protocol

# Windows 便携包
flutter build windows --release
#   → build/windows/x64/runner/Release/ 整个目录打成 zip

# Android
flutter build apk --release
```

## 许可

本项目计划采用 **GPL-3.0-or-later**（与 Mumla 等社区客户端一致，保证衍生作品开源）。
依赖许可：Mumble proto 文件 BSD-3、libopus BSD、miniaudio MIT-0、Flutter BSD-3。

> 尚未定稿，见 [docs/adr/](docs/adr/)。如果你希望保留闭源/上架商业发行的灵活性，应改用 Apache-2.0。

## 免责

点歌台的音源由部署者自行配置并承担合规责任，项目不内置任何需要破解的音源接口。
