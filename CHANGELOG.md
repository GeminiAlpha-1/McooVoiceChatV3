# 更新日志

版本号只用两位 `x.z`：

- **x = 功能更新**：每上线一个新功能 x+1，同时 **z 归零**
- **z = bug 修复**：每修一个线上 bug z+1
- 纯基础设施改动（使用者看不见的改动）不升版本号

## 0.1 — 2026-10-21

框架层首个可运行版本。

### 新增

- **`core/` 框架层**
  - `Store`：跨模块共享状态。扁平点分路径，支持 `.*` 前缀通配订阅
  - `EventBus`：事件总线。`Scope` 绑定模块 ID，模块只能以自己的身份发布/订阅
  - `EventContractRegistry`：事件契约。唯一发布方 + 允许消费者 + payload 校验，违规抛
    `EventContractError`
  - `Module`：模块基类。生命周期入口非虚、钩子可覆盖；模块私有状态与 `shared.*` 共享区
  - `ModuleManager`：模块注册与加载。单个模块 `init()` 失败不影响其它模块，并撤销其契约
  - `Subscription`：退订幂等的订阅句柄，拷贝共享同一次订阅
- **构建**：CMake + Ninja，`MOO_BUILD_TESTS` / `MOO_WARNINGS_AS_ERRORS` 两个开关
- **测试**：5 个 QtTest 用例集，覆盖 Store 通配订阅、事件契约校验、handler 异常隔离、
  面板生命周期、模块加载失败隔离
- **文档**：`README.md`、`AGENTS.md`、`docs/架构.md`

### 已知限制

- `services/`、`modules/`、`ui/` 尚未开工
- 尚未与 Mumble fork 接通（`MainWindow` 的插件面板挂载点未实现）
