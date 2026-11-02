# ADR-0001 客户端技术栈选型

- 状态：**Proposed**（待确认）
- 日期：2026-11-02
- 影响范围：`apps/client`、`packages/mcoo_audio`、`packages/mcoo_native`
- 相关：ADR-0002（服务端策略）、ADR-0003（插件模型）、ADR-0004（协议实现）

## 1. 硬约束

| 编号 | 约束 | 说明 |
|---|---|---|
| C1 | 双端一套代码 | Android + Windows，UI 与业务逻辑只写一遍 |
| C2 | VoIP 级音频 | 全双工；PTT 按下到对端出声 ≤ 150 ms（局域网） |
| C3 | 免安装便携 | Windows 解压即用；不依赖 WebView2、不依赖用户预装 VC++ 运行库 |
| C4 | 可插件扩展 | 不重新编译主体即可新增面板/行为（ADR-0003 落地） |
| C5 | 单人可维护 | 构建链步骤少、失败可定位；CI 能出双端产物 |
| C6 | 许可干净 | 不引入强 copyleft 的运行时依赖 |

## 2. 候选方案对比

评分 1–5，5 最好。**"工具链成本"分数越高代表越省事。**

| 方案 | 音频可控 | 双端一致 | 便携 | 插件 | 工具链 | 许可 | 合计 |
|---|---|---|---|---|---|---|---|
| **A. Flutter + Dart 业务核心 + C 实时薄层（miniaudio/libopus FFI）** | 4 | 5 | 5 | 3 | 3 | 5 | **25** |
| B. Flutter + Rust 核心（Rumble 路线） | 5 | 5 | 5 | 3 | 2 | 5 | 25 |
| C. Tauri 2（Rust 核心 + WebView UI） | 5 | 3 | 2 | 5 | 3 | 5 | 23 |
| D. Electron + WebAudio（v2 路线） | 3 | 1 | 4 | 5 | 5 | 5 | 23 |
| E. 直接改 Mumble（Qt/C++） | 5 | 2 | 3 | 3 | 2 | 4 | 19 |
| F. JUCE | 5 | 2 | 3 | 2 | 2 | 2 | 16 |
| G. EUI-NEO | 1 | 1 | 3 | 2 | 3 | 5 | 15 |

### 逐项否决理由

**D. Electron / WebAudio（v2 路线）** —— 本机唯一"今天就能编译"的方案，但 **Android 无解**：只能套 Capacitor/WebView，音频延迟与后台保活都不可控。语音产品在双端一致性上不能妥协，因此否决。v2 的模块化经验仍然吸收（见 ADR-0003 的槽位设计）。

**E. 直接改 Mumble（Qt/C++）** —— 最省"协议风险"，但 Mumble 客户端与 QtWidgets 深度耦合，换 UI 等于重写客户端；Android 端 Mumble 官方从无先例，Qt for Android 的音频与后台是深水区。业务逻辑可以借鉴，代码不能直接搬。

**F. JUCE** —— 音频引擎一流，但它面向 DAW/插件，缺少成熟的列表/树/富文本/IME 组件；Android 支持薄弱；JUCE 8 的免费档是 AGPLv3，与"保留日后闭源/上架灵活性"冲突。否决。

**G. EUI-NEO** —— C++17 + GLFW/SDL2 + OpenGL/Vulkan 的自绘 UI，渲染效率漂亮，但：无 Android 后端、无音频栈、无成熟 CJK 文本排版与输入法（IME）支持。中文聊天场景下 IME 是硬需求。可作为日后"自绘渲染"的实验参考，不进主路径。

**C. Tauri 2** —— 插件体验最好（Web 技术栈天然支持运行时加载），Rust 音频也强。但 Windows 便携包必须依赖 WebView2（Win10 早期版本未必预装，捆绑 fixed 版要 +100 MB 且升级麻烦），Android 端的音频焦点/前台服务仍需大量自研。**便携性**这一条直接掉档。

**B. Flutter + Rust 核心** —— 技术上最优（Rumble 已验证 Flutter + `flutter_rust_bridge` + Rust 音频可跑通 Android/iOS/Windows/macOS/Linux）。但要多维护一套 Rust 工具链 + 交叉编译 + FFI 绑定生成，对单人维护是纯成本，换来的实时性收益在本方案里被"实时路径已在 C 侧"抵消。

## 3. 决策

**采用方案 A：Flutter（UI） + Dart（业务核心） + C（实时音频薄层）。**

### 为什么 Dart 够用

关键在于**实时线程不进 Dart**：

```
[麦克风] → C: miniaudio 回调 → C: lock-free SPSC 环形缓冲
                                      ↓ (每 10ms 拉取)
                          Dart isolate: Opus 编码 → 组包 → 网络
                                      ↓
[扬声器] ← C: miniaudio 回调 ← C: 环形缓冲 ← Dart: Opus 解码 / 混音
```

- 音频回调、重采样、环形缓冲全在 C，GC 停顿碰不到音频线程；
- Dart 侧只承担 50 次/秒的 Opus 编解码调用（每次 < 1 ms）与网络 IO；
- 抖动缓冲/混音放在 Dart 的独立 isolate，用固定容量预分配缓冲，避免分配抖动。

### 为什么不用 Rust（保留升级路径）

`IAudioDevice`、`ICodec`、`ITransport` 都是 Port（见 `docs/architecture.md`）。若日后 Dart 侧成为瓶颈，把 `packages/mcoo_audio` 换成 Rust adapter 即可，上层零改动。**现在不为想象中的性能问题付工具链成本。**

## 4. 落地约定（不可违反）

1. **Dart 不得进入音频回调**。C 侧回调只做 memcpy 与环形缓冲读写。
2. **原生代码集中**在 `packages/mcoo_native`，以 Flutter FFI plugin 形式提供，CMake 同时服务 Windows(MSVC) 与 Android(NDK)。
3. **Opus 参数**：48 kHz、单声道、20 ms 帧、默认 40 kbps（语音）/ 96 kbps（点歌台立体声）。
4. **不使用 Flutter 的音频插件**（`just_audio`/`record` 等）承担语音通路——它们面向媒体播放，延迟与设备控制不达标；仅点歌台的本地预览可用。
5. 便携模式：可执行文件同级存在 `portable.marker` 时，所有数据写入 `./McooData/`，否则写系统标准目录。

## 5. 后果

**正面**
- 一套 UI 双端跑；Windows 产物是纯文件夹 zip，符合"免安装便携包"。
- 工具链只多 Flutter 一套（VS2022 C++ 工作负载 + Android SDK/NDK 是 Flutter 自身的硬要求）。
- 许可干净：Flutter(BSD-3)、libopus(BSD)、miniaudio(public domain/MIT-0)、protobuf(BSD-3)。

**负面 / 代价**
- **插件不能热加载 Dart 代码**（AOT）。→ 用 ADR-0003 的三层模型规避。
- 需要自己维护 libopus / miniaudio / speexdsp 的双端交叉编译，Android 侧要写 `CMakeLists` + `build.gradle` 的 abiFilters。
- 本机当前**没有任何相关工具链**（无 Flutter / VS / CMake / Android SDK），首次搭建约 10 GB 下载。

## 6. 待确认

- [ ] 用户确认方案 A
- [ ] 授权安装工具链（Flutter SDK、VS2022 Build Tools、Android SDK+NDK、CMake、Ninja）
