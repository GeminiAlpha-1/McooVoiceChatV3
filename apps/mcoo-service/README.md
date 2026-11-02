# apps/mcoo-service

常驻 bot 进程，以普通 Mumble 客户端身份连接服务器，提供两个能力：

1. **AFK**：把长时间无操作的用户移入 AFK 频道，活跃后移回（见 [docs/features/afk.md](../../docs/features/afk.md)）
2. **点歌台**：把音源编码成 Opus 语音包播进频道（见 [docs/features/jukebox.md](../../docs/features/jukebox.md)）

## 为什么是独立进程

murmur 没有动态插件 API，且点歌台必须是一个真正"在频道里说话"的客户端。
做成独立 bot 的好处：**服务端零改动**，原版 Mumble 客户端照常连、照常听；bot 挂了不影响语音主链路。

## 形态

```bash
mcoo-service --config ./mcoo-service.toml
```

- 单可执行文件（Dart AOT 编译），Windows/Linux 都能跑
- 配置热加载（改完不用重启，除连接参数外）
- 状态持久化到 `state.json`（AFK 的原频道映射、点歌队列）
- 内置 HTTP/WS 端口，供客户端点歌台面板消费
- 健康检查端点 `/healthz`，方便 systemd / NSSM 守护

## 依赖

- `packages/mumble_protocol`：连接与语音发包
- `packages/mcoo_audio`：Opus 编码（**不需要音频设备**，只做编解码）
- 外部：`ffmpeg`（解码音源），部署者自行安装；缺失时点歌台降级为"只支持已编码格式"

## 配置骨架

```toml
[server]
host = "voice.example.com"
port = 64738
username = "McooService"
password = ""
# 用证书认证更稳（bot 身份固定，权限好配）
cert_file = "service.pem"

[afk]
enabled = true
channel = "AFK"
idle_seconds = 300
grace_seconds = 30
exempt_groups = ["Admin"]

[jukebox]
enabled = true
channel = "音乐厅"
http_port = 8790
mode = "broadcast"      # broadcast | sync
bitrate = 96000
max_queue_per_user = 3
```

## 待办

见 [docs/roadmap.md](../../docs/roadmap.md) 的 M4 / M5。
