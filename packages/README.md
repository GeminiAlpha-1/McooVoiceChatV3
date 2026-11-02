# packages/

Dart/C 库，全部通过 path 依赖被 `apps/` 引用。**任何包都不允许反向依赖 `apps/`。**

| 包 | 职责 | 依赖 | 状态 |
|---|---|---|---|
| `mumble_protocol` | Mumble 协议编解码、TLS/UDP 传输、OCB、状态机。**纯 Dart，零 Flutter 依赖** | protobuf, pointycastle | M1 |
| `mcoo_audio` | Opus 编解码、抖动缓冲、混音、处理链。设备抽象在 `IAudioDevice` | mcoo_native | M2 |
| `mcoo_native` | C 源码 + CMake：miniaudio / libopus / speexdsp，以 FFI plugin 形式提供双端产物 | — | M2 |
| `mcoo_core` | 领域模型、会话编排、AFK/点歌台用例 | protocol, audio | M1–M5 |
| `mcoo_plugin_api` | 插件契约、manifest 模型、能力枚举 | core | M6 |
| `mcoo_ui_kit` | 设计系统：颜色/间距/字体令牌、通用组件 | Flutter | M3 |

## 约定

- **依赖方向**：`ui_kit` / `plugin_api` → `core` → `protocol` / `audio` → `native`。禁止反向与环。
- **测试优先**：`mumble_protocol`、`mcoo_core` 必须能 `dart test` 跑，不需要 GUI、不需要音频设备。
- **不许有的东西**：全局单例、隐式全局状态、`dart:io` 出现在 Domain 层。
- 每个包自带 `README.md`，写清"这个包不管什么"——边界比功能更重要。
