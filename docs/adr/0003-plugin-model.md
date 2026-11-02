# ADR-0003 插件模型：按"是否需要执行任意代码"切三层

- 状态：**Proposed**
- 日期：2026-11-02
- 影响范围：`packages/mcoo_plugin_api`、`apps/client/lib/plugins`

## 1. 约束

Flutter 用 AOT 编译，**运行时无法加载新的 Dart 代码**。所以不能照搬 VS Code 的"丢一个 JS 目录进去就生效"。同时用户明确要求"保留扩展能力，方便日后插件扩展"。

## 2. 三层模型

| 层 | 名称 | 形态 | 谁能写 | 何时生效 | 权限 |
|---|---|---|---|---|---|
| **L1** | 内置插件 | 仓库内的 Dart package，实现 `McooPlugin` | 我们 | 编译期 | 完全信任 |
| **L2** | 声明式插件 | `manifest.json` + 有限动作集，无代码 | 社区（会写 JSON 即可） | 运行时安装 | 按声明授权 |
| **L3** | 外部服务插件 | 任意语言的可执行文件/服务，本地 WebSocket 通信 | 社区（会写程序） | 运行时启动 | 按声明授权 |

**核心功能（语音、AFK、点歌台）也实现为 L1 插件**，宿主与插件走同一套接口——吃自己的狗粮，保证 API 不会腐化成"只有第三方才用的废接口"。

### 为什么不做 JS 沙箱（QuickJS / WebView）

- 多一个引擎依赖、多两套 API 绑定、多一类崩溃面；
- L2 覆盖"小工具"、L3 覆盖"重逻辑"，中间地带很窄；
- 但**保留接入点**：`IPluginRuntime` 是 Port，日后加 JS runtime 只是新增一个 adapter，不影响已有插件。

## 3. 能力模型（Capability）

插件在 manifest 里声明所需能力，安装/启用时展示给用户：

```json
{
  "id": "com.example.nowplaying",
  "name": "正在播放",
  "version": "1.0.0",
  "apiVersion": 1,
  "capabilities": ["ui.statusbar", "chat.send", "net.outbound:music.example.com"],
  "contributes": {
    "statusbar": [{ "id": "np", "align": "right", "title": "正在播放" }],
    "commands": [{ "id": "np.search", "title": "搜索歌曲" }]
  }
}
```

能力清单（首版）：

| 能力 | 含义 | 风险 |
|---|---|---|
| `ui.panel` | 注册 Dock 面板 | 低 |
| `ui.statusbar` | 状态栏小组件 | 低 |
| `ui.overlay` | 游戏内浮层 | 中 |
| `ui.contextMenu` | 频道/用户右键菜单项 | 低 |
| `notify` | 系统通知 | 低 |
| `chat.send` | 以自己身份发文本消息 | 中 |
| `server.move` | 移动用户/频道 | **高** |
| `user.mute` | 服务端静音他人 | **高** |
| `audio.capture` | 读取麦克风 PCM | **高** |
| `audio.inject` | 向语音通路注入音频 | **高** |
| `net.outbound:<host>` | 出站 HTTP/WS | 中 |
| `fs.user` | 读写用户数据目录 | 中 |
| `storage` | 插件私有 KV | 低 |
| `pluginData` | 收发 Mumble 扩展数据 | 中 |

高权限能力必须逐条勾选，不允许"全选"。

## 4. UI 扩展点（槽位）

| 槽位 | 说明 | 借鉴 |
|---|---|---|
| `panel` | 左侧 Dock 图标 + 弹出面板 | v2 的 Dock 体系（已验证好用） |
| `statusbar.item` | 底部状态栏小组件 | 新 |
| `channel.contextMenu` / `user.contextMenu` | 右键菜单追加项 | 新 |
| `settings.page` | 设置页新增分页 | 新 |
| `overlay` | 游戏内浮层 | 新 |
| `command` | 命令面板条目（Ctrl+K） | 新 |
| `chat.renderer` | 自定义消息卡片渲染 | 借鉴 Mumcord 的 message card |

槽位由宿主渲染，插件只提供**数据 + 动作 id**，L2 插件因此可以零代码接入 UI。

## 5. 生命周期

```
install → enable → activate(ctx) → [running] → deactivate → uninstall
```

- `ctx` 是 **scoped API 对象**：`deactivate` 后所有句柄（定时器、订阅、面板、网络连接）立即失效，插件无法"诈尸"。
- 所有注册项带 owner id，卸载时按 owner 批量回收（v2 的 `_clearModuleResources` 思路，已验证能防泄漏）。
- 插件异常**不得**拖垮主进程：L1 用 try/catch + 错误边界；L2/L3 天然隔离。

## 6. 分发

- 首版：本地目录安装（拖入 zip），manifest 校验 + 能力确认弹窗。
- 后续：官方索引（签名 manifest），可选自动更新。
- **不做**应用内执行任意二进制下载——L3 插件必须用户手动放置并确认。

## 7. 后果

- 正面：扩展性有保证，且三层各自的安全模型清晰；核心功能与第三方走同一套 API。
- 负面：L1 插件需要重新编译（对官方功能不是问题）；L2 表达能力有限（这是刻意的）；L3 需要用户有一定的动手能力。
