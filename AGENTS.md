# MOO 语音软件框架层 — 协作规范

> 本仓库是 MOO 语音软件（3.0）的**框架层**。
> 完整架构见 [`docs/架构.md`](docs/架构.md)。
>
> MOO 语音软件本体是 Mumble fork，fork 侧另有一份 `AGENTS-moo.md` 管「怎么改 Mumble 的代码」，
> 本文件管「我们的架构怎么搭」。

---

## 1. 铁律：不重写 Mumble 的核心

这条来自实际教训。2.0 在 LiveKit 上重写了降噪、麦克风识别等底层能力，
结果慢、BUG 多，最终整个项目无法使用。

**因此严禁触碰以下路径**（它们在 Mumble fork 里，不在本仓库）：

| 路径 | 内容 | 禁止原因 |
|---|---|---|
| `src/mumble/AudioInput.cpp` `AudioOutput.cpp` | 音频采集/播放 | 降噪、回声消除、VAD 都在这 |
| `src/mumble/WASAPI.cpp` 等 | 音频后端 | 设备管理、缓冲策略 |
| `src/crypto/` | TLS + OCB2 加密 | 协议安全性 |
| `src/Net.cpp` `Connection.cpp` `MumbleProtocol.cpp` | 网络协议 | 握手、编解码 |
| `src/murmur/` | 服务端 | 本项目不 fork 服务端 |

**本仓库只负责架构成型**：Store、EventBus、事件契约、模块生命周期。

---

## 2. 分层与依赖方向

```
modules/   →  依赖 core/ 与 services/ 的接口
services/  →  依赖 Mumble 内部 API，向模块暴露稳定接口
core/      →  不依赖任何上层
```

**依赖只能向下。** `core/` 不准 include `services/` 或 `modules/`。

### 2.1 模块间不互相引用

- 模块 A **永远不知道** 模块 B 存在
- 跨模块通信只有三条路：
  1. **Store 跨模块共享区**（`shared.*`）—— 读状态
  2. **EventBus** —— 实时通知
  3. **Service API** —— 执行操作

> 判据：新增一个模块时，`core/` 和 `services/` **一行都不用改**。

---

## 3. 事件契约

契约由**发布方模块自己声明**（`Module::eventContracts()`），框架不预置任何事件。
新增事件时必须同时定义：

1. **唯一发布方** —— 别的模块发不了
2. **允许消费者** —— 哪些模块可以订阅
3. **payload 校验函数** —— 结构与类型

违规行为（错误发布方 / 未授权订阅 / payload 不合法）**直接抛 `EventContractError`**。

事件命名：`域:事件名`（如 `room:connected`、`jukebox:state-changed`）。
发布方用模块 ID，消费者用模块 ID。

---

## 4. 异常隔离

模块是隔离单元，一个模块炸了不能影响其它模块：

| 场景 | 要求 |
|---|---|
| 模块 `init()` 抛异常 | 记录并跳过该模块，**其它模块继续加载**；撤销该模块登记的契约 |
| EventBus handler 抛异常 | 记录 **事件名 / 发布方 / 消费者模块 ID / 异常内容**，其它 handler 继续执行 |
| Store 订阅者抛异常 | 记录 **路径 / 异常内容**，写入本身照常完成，其它订阅者照常收到 |
| 模块 `destroy()` 抛异常 | 记录并继续卸载其它模块 |

> **禁止静默吞错。** 必须留下可定位的日志。

---

## 5. 资源回收

模块生命周期内创建的一切，必须在 `destroy()` 前全部清理：

| 资源 | 作用域 | 接口 |
|---|---|---|
| 定时器 | 面板级 | `Module::defer()` / `Module::repeat()` / `Module::frame()` |
| 状态订阅 | 模块级 | `Module::watch()` |
| 事件订阅 | 模块级 | `Module::on()` |

**额外要求**：模块面板关闭后，已排队的回调**不得再执行**。
用 `m_lifecycleVersion` 计数器实现（照搬 2.0 的做法）——每次面板关闭自增，回调执行前比对版本号。

`Subscription` 的退订是**幂等**的：模块内部留一份、调用方留一份，两边指向同一次订阅，
任何一边取消都会让另一边失效。模块卸载时必须**显式** `cancel()`，
只清容器的话，调用方持有的那份句柄会让订阅继续活着。

---

## 6. UI 规范

- 颜色**一律引用 QSS 变量**，不硬编码色值
- 动效代码集中在**单独文件**，不散落在各个 UI 文件里
- 尊重 `prefers-reduced-motion`：系统关闭动画时不能出现硬切
- 圆角、间距等尺度用统一令牌，不各写各的

---

## 7. 编码约定

- 缩进用 **Tab**
- 格式用 `clang-format`（CI 固定 **版本 10**）
- 警告即错误（`MOO_WARNINGS_AS_ERRORS=ON`），不留 warning
- 注释只写「为什么」，不写「是什么」；不叙述代码历史
- `assert()` 内的代码不保证执行，仅在断言里用的变量标 `[[maybe_unused]]`
- **文件名小写 + 下划线**（`event_bus.h`），头文件用 `#pragma once`
- 源码含中文，**MSVC 必须开 `/utf-8`**（已在顶层 `CMakeLists.txt` 里配好）
- 事件发布方法叫 `publish` **不叫 `emit`**——`emit` 是 Qt 的宏，会被预处理成空

---

## 8. 版本号

只用两位 `x.z`：

- **x = 功能更新**：每上线一个新功能 x+1，同时 **z 归零**
- **z = bug 修复**：每修一个线上 bug z+1
- 纯基础设施改动（使用者看不见的改动）**不升版本号**

唯一出处是顶层 `CMakeLists.txt` 的 `project(... VERSION ...)`。

---

## 9. 提交约定

- 主题行：`TYPE(Scope): Summary`，`TYPE` 取自 Mumble 上游 `COMMIT_GUIDELINES.md`，
  且**必须全大写**（上游 CI 脚本强制检查）
- **一个提交只做一件事**，即使任务相关也要拆开
- 每个提交**独立可编译**
- 提交信息结尾加一行 `AI-assisted`（不写具体工具名，不加 `Co-Authored-By`）

---

## 10. 自测纪律

**改完必须自测通过再报告。** 不自测就报告「好了」是红线。

最低自测清单：

1. 编译无 warning、无 error
2. `ctest --output-on-failure` 全绿
3. 改动的功能实际可用（不是只看语法就宣称完成）
4. 日志无异常
5. 未破坏相邻功能（跑一遍基本路径）

---

## 11. 构建

依赖 Qt 6.9（Core + Test）、CMake 3.28+、Ninja。
Windows 上用 vcpkg 提供 Qt 时指定工具链与 triplet：

```
cmake -S . -B build -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_TOOLCHAIN_FILE=<vcpkg>/scripts/buildsystems/vcpkg.cmake \
  -DVCPKG_TARGET_TRIPLET=x64-windows-static-md
cmake --build build
cd build && ctest --output-on-failure
```

---

## 12. Windows 分发

- **只出便携版**，不做安装器
- CMake `packaging` 选项保持 **OFF**
- 打包脚本放 `tools/`，输出整个目录 + zip
