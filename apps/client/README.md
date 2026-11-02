# apps/client

Flutter 客户端（Windows 便携包 + Android）。

## 状态

**尚未生成**。等工具链装好后执行：

```bash
flutter create --platforms=windows,android \
  --org app.mcoo --project-name mcoo_voice \
  apps/client
```

> 为什么现在不手写：`android/` 与 `windows/` 下的 Gradle / CMake 工程由 `flutter create` 按当前 SDK 版本生成，手写会与 SDK 版本错配，修起来比重建还慢。

## 生成后的结构约定

```
lib/
├── main.dart              # 入口：组装 DI、跑 App
├── di.dart                # Provider 定义（唯一允许 new Adapter 的地方）
├── app/                   # shell：窗口、路由、主题、托盘、快捷键、便携模式
├── features/
│   ├── servers/           # 服务器列表、连接管理
│   ├── channels/          # 频道树
│   ├── users/             # 用户列表、说话状态
│   ├── chat/              # 文本消息
│   ├── jukebox/           # 点歌台面板
│   └── settings/          # 设置
└── plugins/               # 插件宿主 + 内置插件注册表
```

## 硬性约定

1. `features/` 下的 Widget **不许**直接调用 `mumble_protocol` 的 Transport，只能经 Riverpod Notifier。
2. 所有颜色/间距走 `mcoo_ui_kit` 的令牌，禁止硬编码色值（v2 踩过：新加的行没有样式）。
3. 便携模式：exe 同级存在 `portable.marker` → 数据目录用 `./McooData/`。
4. 窗口最小尺寸 960×600（桌面），移动端不做平板适配（M3 之后再评估）。

## 待办

见 [docs/roadmap.md](../../docs/roadmap.md) 的 M3。
