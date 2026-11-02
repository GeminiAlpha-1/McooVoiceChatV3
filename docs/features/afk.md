# 功能设计：类 TeamSpeak 的 AFK 状态

## 1. TeamSpeak 的原始语义（我们要对齐的）

1. 服务器上有一个被标记为 **AFK 频道** 的特殊频道。
2. 用户连续无操作超过阈值 → 被**移动到 AFK 频道**。
3. 用户恢复活动（说话 / 操作客户端 / 自己加入某频道）→ **自动移回原频道**。
4. UI 上该用户显示 **AFK 徽标**与状态文字（"离开"、"挂机中"）。
5. 部分版本支持"用户主动设置离开状态"（away），与"系统判定 AFK"是两回事。

第 5 点很重要：**主动 away ≠ 系统 AFK**。前者是用户表达，后者是行为推断。两者在 UI 上要区分。

## 2. Mumble 里缺什么

| 需要 | Mumble 有吗 |
|---|---|
| AFK 频道这个概念 | ❌ 频道没有类型标记 |
| 服务端自动移动空闲用户 | ❌ 无 |
| 用户空闲时长 | ⚠️ 仅 `UserStats.idlesecs`，语义是"距上次语音/文本活动"，**不反映键鼠操作** |
| 客户端扩展状态 | ✅ `PluginDataTransmission`（1.5+）、`UserState.comment`（低版本兜底） |
| 主动 away | ⚠️ 可用 `UserState.self_deaf` 近似，但语义不同，不推荐挪用 |

## 3. 设计

### 3.1 谁是 AFK 频道

不硬编码名字。由 `mcoo-service` 的配置指定：

```toml
[afk]
enabled = true
channel = "AFK"          # 频道名，支持 "/" 分隔的路径
idle_seconds = 300       # 5 分钟
grace_seconds = 30       # 被移动后的冷却，防抖
exempt_groups = ["Admin"] # 这些组永不被移动
restore = true           # 活跃后自动移回原频道
```

- 频道不存在时 bot 自动创建（需要 `MakeChannel` 权限），并写一条频道描述说明用途。
- 频道**不设置**任何特殊 ACL——它就是个普通频道，原版客户端看到的就是"一个叫 AFK 的频道"。

### 3.2 空闲判定：双源融合

```
idle = min(idle_from_client, idle_from_server)   # 任一源认为活跃就算活跃
```

- **客户端源（主）**：我们的客户端每 30 s 通过 `PluginDataTransmission` 上报：

  ```json
  { "v": 1, "type": "mcoo.afk.heartbeat", "lastInputMs": 12345, "away": false }
  ```

  `lastInputMs` = 距最后一次键鼠/触摸输入的毫秒数（桌面监听全局输入，Android 监听触摸与前台状态）。
- **服务端源（兜底）**：原版客户端不上报，用 `UserStats.idlesecs`。
- **失联处理**：客户端 90 s 没心跳 → 该源失效，退回服务端源。

> 为什么不用 `UserStats.idlesecs` 单干：一个在看视频/听歌但没说话的人，`idlesecs` 会一路涨到阈值，被误踢进 AFK——这是最招人烦的 bug。

### 3.3 移动与恢复

```
每 5 s 轮询：
  for user in online_users:
    if user.channel == afk_channel: continue
    if user in exempt: continue
    if now - last_move[user] < grace: continue
    if idle(user) > idle_seconds:
      prev_channel[user] = user.channel
      Move(user -> afk_channel)
      last_move[user] = now
      broadcast plugin_data(afk: true)
  for user in afk_users:
    if idle(user) < 10:            # 明显活跃
      Move(user -> prev_channel[user] or 根频道)
      delete prev_channel[user]
      broadcast plugin_data(afk: false)
```

**防抖**（关键，否则会和用户手动操作打架）：

| 情况 | 处理 |
|---|---|
| 用户被移动后 30 s 内自己移走 | 尊重用户，记 `manual_override`，10 分钟内不再动他 |
| 用户连续被移动 3 次 | 拉黑 30 分钟，日志记一条 |
| bot 重启 | 从 `state.json` 恢复 `prev_channel` 映射；找不到就回根频道 |
| 用户断线重连 | session 变了，映射失效，按新用户处理 |

### 3.4 客户端展示

- **频道树**：AFK 频道用 🌙 图标 + 灰色文字；人数徽标照常。
- **用户列表**：AFK 用户在名字后加 `AFK` 徽标（胶囊形，低饱和），hover 显示"已离开 12 分钟 · 原频道：大厅"。
- **主动 away**：用户在客户端设置里点"离开"→ 名字变灰 + `away` 图标，与系统 AFK 视觉上区分（系统 AFK 是胶囊标签，主动 away 是图标）。
- **自己**：如果自己被移入 AFK，顶部弹一条非阻塞提示："你已进入 AFK 频道（5 分钟无操作），点击返回大厅"。

### 3.5 协议侧

- 移动 = 标准 `UserState { session, channel_id }`，原版服务器照常处理。
- 状态广播 = `PluginDataTransmission`（1.5+）。**低版本服务器降级**：不发扩展数据，UI 只能靠"是否在 AFK 频道"推断，徽标仍可显示，但没有"原频道/时长"。

## 4. 与 v2 的关系

v2 的 `afk` 模块是**纯客户端**的：用户自己设置状态文字，写进 LiveKit 的 participant metadata，别人读到就显示。它解决的是"主动 away"，没有服务端移动逻辑。

V3 保留 v2 的"主动 away"（用户表达），新增"系统 AFK"（行为推断），两者独立、可同时存在。v2 的 `share('afk', {...})` 跨模块共享模式，在 V3 里换成 `AfkState` Notifier + 事件流。

## 5. 验收标准

- [ ] 原版 Mumble 客户端用户，5 分钟无语音/文本 → 被移入 AFK 频道，其客户端无报错
- [ ] 该用户按下 PTT 说话 → 10 s 内被移回原频道
- [ ] 我们的客户端用户，看视频 10 分钟不说话（有键鼠操作）→ **不被移动**
- [ ] 用户手动离开 AFK 频道 → 10 分钟内不再被移动
- [ ] bot 重启 → 已记录的 `prev_channel` 仍能正确恢复
- [ ] AFK 频道不存在时自动创建且带说明描述
