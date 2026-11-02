# 功能设计：点歌台

## 1. 两种形态，先说清取舍

| 形态 | 原理 | 谁能听到 | 带宽 | 音质 | 同步 |
|---|---|---|---|---|---|
| **A. 广播模式** | bot 加入频道，把音源编码成 Opus 语音包发出去 | **所有人**，含原版 Mumble 客户端 | 占用服务器语音带宽（96 kbps/人） | 受 Opus 限制 | 天然同步 |
| **B. 同步模式** | 每个客户端本地播放，按服务端时间戳对齐 | 只有装了 Mcoo 客户端的人 | 零（各自拉流） | 无损 | 需时钟对齐，会漂移 |

**决策：以 A 为主，B 作为可选增强。**

理由：社区语音的核心体验是"大家一起听"，原版客户端用户不该被排除在外；A 不需要客户端时钟同步，实现与排障都简单得多。B 作为"局域网/高音质"选项保留（复用 v2 的本地播放逻辑）。

> v2 的做法本质是 B：服务端存队列 + SSE 推状态 + 每个客户端 `<audio>` 本地播放（音量 0.3）。它的优点是零带宽、音质无损；缺点是没装客户端的人听不到，且没有真正的同步机制（各人按自己收到状态的时间开始播，误差几百毫秒到几秒）。V3 的 A 模式补上这个洞。

## 2. 架构

```
┌──────────────┐   HTTP/WS    ┌────────────────────┐   Mumble 协议   ┌──────────┐
│ Flutter 客户端│ ───────────→ │  mcoo-service      │ ─────────────→ │ murmur   │
│  点歌台面板   │ ←─────────── │   jukebox 模块     │ ←───────────── │          │
└──────────────┘  队列/进度    └────────────────────┘                 └──────────┘
                                        │
                                        ├─ ffmpeg 子进程（解码 → PCM 48k）
                                        ├─ Opus 编码器（96 kbps 立体声）
                                        └─ 20ms 实时时钟发送
```

- **队列状态在服务端**，单一事实来源。客户端只是视图。
- **播放进度**由服务端按已发送帧数推算，随 WS 快照下发；客户端据此画进度条，不做本地计时（避免漂移）。

## 3. 队列模型

```dart
class Track {
  final String id;          // 稳定 id（音源类型 + 音源 id）
  final String title;
  final String artist;
  final Duration duration;
  final String requester;   // 点歌人昵称
  final TrackSource source; // netease / local / url / radio
  final String? coverUrl;
}

class JukeboxState {
  final int revision;       // 单调递增，客户端丢弃旧快照
  final Track? current;
  final List<Track> queue;
  final bool playing;
  final Duration position;
  final JukeboxMode mode;   // broadcast | sync
}
```

`revision` 单调递增是 v2 已经验证过的做法（`_applyState` 里 `data.revision < this._state.revision` 直接丢弃），V3 沿用——这是解决"乱序推送导致 UI 回跳"的最小成本方案。

## 4. 播放管线（广播模式）

```
ffmpeg -i <source> -f s16le -ar 48000 -ac 2 -   # 解码为裸 PCM
  → 环形缓冲（3 秒水位，抗抖动）
  → 每 20ms 取 960 帧（立体声）
  → Opus encode(96kbps, 20ms)
  → VoicePacket(target = 0)
  → UDP（失败则 TCP 隧道）
```

要点：

- **实时时钟驱动，不用"尽快发送"**：以 `Stopwatch` 为基准，落后就丢帧（避免雪崩），领先就等待。落后超过 500 ms 直接跳到最新位置并记一条日志。
- **曲间淡出**：切歌时先发 200 ms 静音帧，避免爆音。
- **暂停**：发终止帧（Opus terminator），不再发包；恢复时重置 seq。
- **音源解码失败**：跳过该曲，队列里标红，继续下一首。

## 5. 音源适配

音源做成 **Provider 接口**（这里是真需要抽象的地方——实现多、且每个都要独立配置）：

```dart
abstract class TrackProvider {
  String get id;
  Future<List<Track>> search(String query, {int limit = 20});
  Future<List<Track>> resolvePlaylist(String url);
  Stream<List<int>> openPcmStream(Track track);   // 已是 48k/16bit/立体声
}
```

首版实现：

| Provider | 说明 | 注意 |
|---|---|---|
| `LocalFileProvider` | 本地目录扫描 | 最稳，无版权风险 |
| `UrlProvider` | 直链音频/网络电台 | 支持 m3u8/pls 解析 |
| `NeteaseProvider` | 网易云（搜索 + 歌单） | **需要用户自备 Cookie**，代码不内置任何密钥；v2 的 `data/netease-cookies.json` 思路沿用 |

**不内置**任何需要破解/绕过的音源。YouTube 等需要 `yt-dlp` 的，做成可选 provider，部署者自行安装并承担合规责任。

## 6. 客户端面板

复用 v2 点歌台的视觉骨架（黑胶唱片 + 进度条 + 搜索 + 队列），因为那套设计已经过用户认可：

```
┌───────────────────────────┬──────────────────────┐
│   ◉ 旋转唱片（封面）        │  🔍 搜索歌曲…         │
│                           │  ┌──────────────────┐ │
│   歌名                     │  │ 结果列表  + 点歌  │ │
│   歌手                     │  └──────────────────┘ │
│   ▬▬▬▬▬▬▬▭▭▭ 1:23/4:05    │  播放队列 (3)         │
│   ⏯  ⏭  🗑  📀            │  · 曲目 A  小明       │
└───────────────────────────┴──────────────────────┘
```

与 v2 的差异：

- 进度条由服务端 `position` 驱动，不再读本地 `audio.currentTime`；
- 切歌/清空等操作走 WS 命令，带 `expectedRevision` 做乐观并发（v2 的 `_skip(revision)` 已这么做）；
- 队列项显示点歌人 + 时长 + 拖拽排序（v2 没有）。

## 7. 权限与公平

| 规则 | 默认 |
|---|---|
| 谁可以点歌 | 频道内所有人 |
| 每人队列上限 | 3 首 |
| 单曲时长上限 | 10 分钟 |
| 跳过 | 投票（过半）或管理员直接跳 |
| 禁播名单 | 配置里的正则/关键词 |

## 8. 与 v2 的关系

**复用**：队列状态机、revision 防回跳、搜索/导入歌单的交互流程、唱片 UI。
**不照搬**：v2 把播放器放在客户端（`new Audio()`），V3 放到服务端 bot；v2 的 SSE 换成 WS（双向，要发命令）。

## 9. 验收标准

- [ ] 原版 Mumble 客户端进入频道后能听到点歌台的歌
- [ ] 切歌后所有客户端看到的队列一致（revision 单调）
- [ ] 连续播放 2 小时不漂移、不爆音、内存不增长
- [ ] 解码失败的曲目被跳过且队列有标记，不卡住播放
- [ ] 点歌台关闭时频道恢复正常语音，无残留静音
