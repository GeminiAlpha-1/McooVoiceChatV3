# apps/mcoo-service

点歌台的**队列与时钟服务**，默认不连 Mumble。

| 模式 | 它是什么 | 需要 Mumble 权限吗 |
|---|---|---|
| `local`（默认） | 一个 HTTP/WS 服务：维护队列、算开播时刻、收集客户端就绪回执 | ❌ 完全不需要 |
| `broadcast`（可选） | 在上面基础上，额外以普通客户端身份把 Opus 播进频道，让原版 Mumble 客户端也能听 | ✅ 需要 Enter / Speak |

> **用户状态（presence）不在这里**——那是客户端之间的事，走 `PluginDataTransmission`，不需要任何服务端进程。
> 详见 [docs/features/presence.md](../../docs/features/presence.md) 与 [docs/features/jukebox.md](../../docs/features/jukebox.md)。

## 为什么本地播放模式下不需要连 Mumble

本地播放的同步只依赖两样东西：**队列状态**和**开播时刻**。客户端各自下载、各自播放，服务端不参与音频链路。所以它就是个普通的 Web 服务，不需要 bot 身份、不需要频道权限、不会因为"bot 掉线"导致全场静音。

只有开启 `broadcast` 模式（照顾原版客户端）时，才需要真的进频道说话。

## 形态

```bash
mcoo-service --config ./mcoo-service.toml
```

- 单可执行文件（Dart AOT 编译），Windows / Linux 都能跑
- 配置热加载（连接参数除外）
- 状态持久化到 `state.json`（队列、播放位置）
- HTTP/WS 端口供客户端消费；`/healthz` 供 systemd / NSSM 守护
- **无状态也能跑**：客户端全部离线时队列保留，重连后状态一致

## 接口草案

| 方法 | 路径 | 说明 |
|---|---|---|
| `GET` | `/api/state?room=<id>` | 当前队列快照（含 `revision`、`startAt`、`position`） |
| `POST` | `/api/queue` | 点歌（带 `expectedRevision` 做乐观并发） |
| `POST` | `/api/skip` | 跳过（投票或管理员） |
| `DELETE` | `/api/queue/:index` | 移除队列项 |
| `GET` | `/api/search?q=` | 搜索（转发给音源 Provider） |
| `WS` | `/ws` | 状态推送 + 命令通道 + 时钟同步（`ping/pong` 带服务端单调时钟） |
| `GET` | `/healthz` | 健康检查 |

## 依赖

- `packages/mumble_protocol`：仅 `broadcast` 模式需要（连接 + 语音发包）
- `packages/mcoo_audio`：仅 `broadcast` 模式需要（Opus 编码，**不需要音频设备**）
- 外部：`ffmpeg`（仅 `broadcast` 模式解码音源），部署者自行安装

## 配置骨架

```toml
[service]
http_port = 8790
state_file = "./state.json"
# 允许的客户端来源（CORS / WS origin）
allowed_origins = ["http://localhost", "app://mcoo"]

[jukebox]
enabled = true
mode = "local"            # local | broadcast
max_queue_per_user = 3
max_track_seconds = 600
cache_hint_mb = 2048      # 仅提示客户端，实际由客户端自己管

# 以下仅 broadcast 模式需要
[server]
host = "voice.example.com"
port = 64738
username = "McooJukebox"
cert_file = "service.pem"
channel = "音乐厅"
bitrate = 96000
```

## 待办

见 [docs/roadmap.md](../../docs/roadmap.md) 的 M5。
