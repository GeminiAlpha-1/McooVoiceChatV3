# 路线图

> 原则：每个里程碑都要有**可验证的产物**，不允许"写完了但跑不起来"。
> 状态：⬜ 未开始 · 🟨 进行中 · ✅ 完成

## M0 决策与骨架（当前）

- ✅ 调研 Mumble 生态（Mumble / Rumble / Mumla+Humla / Mumcord）
- ✅ 技术栈选型（ADR-0001）
- ✅ 服务端策略（ADR-0002）
- ✅ 插件模型（ADR-0003）
- ✅ 协议方案（ADR-0004）
- ✅ 仓库骨架与文档
- ⬜ 工具链安装
- ⬜ 推送初始提交到 GitHub

**验收**：仓库可 `git clone` 后看懂全貌；文档能回答"为什么不用 X"。

## M1 协议核心（纯 Dart，无 UI）

目标：`packages/mumble_protocol` 能连上真实服务器，拿到频道树与用户表。

- ✅ vendor 官方 `Mumble.proto` / `MumbleUDP.proto` + protoc 生成
- ✅ varint 编解码 + 边界测试（含负数取反编码、无符号语义、递归保护）
- ✅ TCP 2+4 分帧（半包/粘包/畸形长度）+ 消息类型常量
- ⬜ TLS 连接（自签证书 + 指纹记忆）
- ⬜ 握手：Version → Authenticate → ServerSync
- ⬜ 状态机：ChannelState / UserState / UserRemove 增量应用
- ⬜ 文本消息收发
- ⬜ 心跳与延迟统计
- ⬜ 抓包 golden 测试

**验收**：`dart run example/list_channels.dart <host> <user> <pass>` 打印正确的频道树。
**风险**：TLS 证书校验策略（自签证书很常见，需要"记住指纹"而不是直接拒绝）。

## M2 音频通路（Windows 优先）

- ⬜ `mcoo_native`：miniaudio + libopus 的 CMake 构建（Windows MSVC）
- ⬜ 环形缓冲（C 侧 lock-free SPSC）
- ⬜ Opus 编解码 FFI 绑定
- ⬜ 抖动缓冲 + 丢包隐藏
- ⬜ 混音器（多用户 + 每用户音量）
- ⬜ UDP 传输 + OCB + 连通性探测 + TCP 隧道降级
- ⬜ PTT 按键通路

**验收**：与官方 Mumble 客户端同服双向通话，主观延迟 ≤ 150 ms。
**风险**：OCB 实现正确性；UDP 被防火墙拦时的降级逻辑。

## M3 UI 骨架（TeamSpeak 风格）

- ⬜ 设计系统：颜色/间距/字体令牌，深浅主题
- ⬜ 服务器列表 + 连接/断开流程
- ⬜ 频道树（拖拽移动、右键菜单、链接频道标记）
- ⬜ 用户列表（说话高亮、静音图标、音量条）
- ⬜ 聊天面板（频道/私聊切换、未读徽标）
- ⬜ 设置页（音频设备、PTT、通知、网络）
- ⬜ 状态栏 + Dock

**验收**：不接服务器也能用假数据走通所有界面；接上服务器后功能可用。

## M4 用户状态与账号

**Presence**

- ⬜ `PresenceService`：状态模型、本地立即生效、`until` 到期恢复
- ⬜ `PluginDataTransmission` 广播与快照请求
- ⬜ 自动离开（全局输入监听 → away，仅改显示不移动用户）
- ⬜ UI：用户列表胶囊标签、状态栏切换菜单、自定义弹窗

**账号**

- ⬜ 证书生成/存储/导入导出（系统安全存储）
- ⬜ 首次连接向导：昵称 → 注册（`UserState{user_id}`）→ 完成
- ⬜ 账号页：头像、证书指纹、注销
- ⬜ 与官方客户端共存测试

**验收**：见 [features/presence.md](features/presence.md) 与 [features/accounts.md](features/accounts.md) 的验收清单。

## M5 点歌台（本地播放）

- ⬜ `apps/mcoo-service`：队列 + WS API + 时钟同步端点
- ⬜ 客户端：音源下载、缓存（LRU）、缓冲就绪上报
- ⬜ 时钟同步（NTP 式测时）+ 开播调度 + 漂移校正
- ⬜ 音源 Provider（本地文件 / URL 直链）
- ⬜ 客户端面板（唱片 UI、搜索、队列、投票跳过）
- ⬜ 可选：`broadcast` 模式（bot 转播给原版客户端）

**验收**：见 [features/jukebox.md](features/jukebox.md) 的验收清单。

## M6 插件系统

- ⬜ `mcoo_plugin_api`：manifest 模型、能力枚举、生命周期
- ⬜ 插件宿主：槽位注册、资源回收、错误边界
- ⬜ 把语音/AFK/点歌台改造成 L1 插件（验证 API）
- ⬜ L2 声明式插件解释器
- ⬜ L3 外部服务插件 WS 桥
- ⬜ 插件开发文档 + 示例

**验收**：写一个"第三方"示例插件（不碰主仓代码），能注册面板并收发消息。

## M7 Android 适配

- ⬜ NDK 交叉编译（arm64-v8a / armeabi-v7a / x86_64）
- ⬜ AAudio/OpenSL 音频路径与设备切换
- ⬜ 前台服务 + 通知（通话中保活）
- ⬜ 音频焦点、蓝牙耳机、免提切换
- ⬜ 后台保活策略（厂商白名单引导）
- ⬜ 触摸 PTT / 悬浮 PTT

**验收**：中端安卓机锁屏后仍能收发语音 ≥ 30 分钟。
**风险**：这是全项目最难的一块（Mumla 也在这里反复踩坑），预留最多缓冲时间。

## M8 打包与发布

- ⬜ Windows 便携包（zip，含 `portable.marker`，数据写 `./McooData/`）
- ⬜ 便携包自检脚本（缺 VC++ 运行库时给提示）
- ⬜ Android 签名 APK/AAB
- ⬜ GitHub Actions：Windows + Android 双端构建、单元测试、产物上传
- ⬜ 版本号策略与更新检查

**验收**：把 zip 拷到一台干净的 Windows 上，解压双击就能连服务器说话。

---

## 依赖关系

```
M0 → M1 → M2 → M3 → M4 → M5 → M6
                ↘ M7（可与 M4/M5 并行）
                        ↘ M8
```

M1 完成前不要碰 UI——协议没跑通时，UI 的每个 bug 都会让人怀疑是协议问题。

## 不做（明确划界）

- ❌ 自己实现 murmur 服务端
- ❌ CELT / Speex 编解码（只保留 Opus，老服务器提示降级）
- ❌ iOS（暂不排期，Flutter 代码结构上不排斥）
- ❌ 应用内执行任意下载的二进制（插件必须用户手动放置）
- ❌ 内置任何需要破解的音源
