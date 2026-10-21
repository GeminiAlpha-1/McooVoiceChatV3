# MOO 语音软件框架层

MOO 语音软件（3.0）的**框架层**仓库。

MOO 语音软件本身是一个 Mumble fork：语音编解码（Opus）、降噪与回声消除、麦克风设备管理、
加密（TLS + OCB2）、网络协议、ACL 全部沿用 Mumble 的成熟实现，不重写。
本仓库提供的是**架构成型的那一层**——让功能模块能像 2.0 那样被拆开、隔离、插拔。

架构思路参考 McooVoiceChat 2.0 的模块化设计，踩过的坑也一并继承：
2.0 把降噪、麦克风识别这些底层能力重写了一遍，慢、BUG 多，最终整个项目没人愿意打开。
3.0 反过来——**底层不动，只在上面搭架子**。

## 当前状态

框架层（`core/`）已实现并通过单元测试：

| 组件 | 职责 |
|---|---|
| `Store` | 跨模块共享状态。扁平点分路径，支持 `.*` 前缀通配订阅 |
| `EventBus` | 事件总线。模块拿到的是绑定自己 ID 的受限视图，只能以自己的身份发布/订阅 |
| `EventContractRegistry` | 事件契约。唯一发布方、允许消费者、payload 校验 |
| `Module` | 模块基类。生命周期、状态命名空间、定时器、订阅 |
| `ModuleManager` | 模块注册与加载。**一个模块炸了不影响其它模块** |

`services/`（能力适配层）、`modules/`（功能模块）、`ui/`（通用 UI 组件）尚未开工。

## 目录结构

```
core/       框架层。不依赖任何上层
services/   能力适配层。唯一允许触碰 Mumble 内部 API 的地方
modules/    功能模块。模块之间互不认识
ui/         通用 UI 组件与 QSS 变量体系
tests/      单元测试
docs/       架构文档
```

## 构建

依赖 **Qt 6.9**（Core + Test）与 CMake 3.28+、Ninja。

```bash
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

Windows 上如果用 vcpkg 提供 Qt，需要指定工具链与 triplet：

```bash
cmake -S . -B build -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_TOOLCHAIN_FILE=<vcpkg>/scripts/buildsystems/vcpkg.cmake \
  -DVCPKG_TARGET_TRIPLET=x64-windows-static-md
```

CMake 选项：

| 选项 | 默认 | 说明 |
|---|---|---|
| `MOO_BUILD_TESTS` | `ON` | 构建单元测试 |
| `MOO_WARNINGS_AS_ERRORS` | `ON` | 警告即错误 |

## 跑测试

```bash
cd build && ctest --output-on-failure
```

## 写一个模块

模块之间互不认识，通信只走 Store、EventBus、Service API 三条路。
新增模块时 `core/` 和 `services/` **一行都不用改**——这是判断依赖方向对不对的硬指标。

```cpp
#include "core/module.h"

using namespace moo;

class JukeboxModule : public Module {
public:
	JukeboxModule() : Module("jukebox", "点歌台") {}

	// 声明本模块发布的事件。唯一发布方是自己。
	QList< EventContract > eventContracts() const override {
		return { EventContract("jukebox:state-changed", "jukebox", { "ui" }) };
	}

protected:
	void init() override {
		// 订阅其它模块的事件：不在允许消费者名单里会直接抛错。
		on("room:connected", [this](const QVariant &payload) {
			publish("jukebox:state-changed", payload);
		});
	}

	void onPanelOpened() override {
		// 定时器是面板作用域的：面板关闭后回调不再执行。
		repeat(1000, [this]() { /* 刷新界面 */ });
	}
};
```

注册与加载：

```cpp
Store store;
EventBus events;
ModuleManager manager(&store, &events);

manager.registerModule(std::make_unique< JukeboxModule >());
manager.initAll();
```

## 详细文档

- [`docs/架构.md`](docs/架构.md) —— 分层、组件职责、模块开发指南
- [`AGENTS.md`](AGENTS.md) —— 协作规范（依赖方向、事件契约、异常隔离、提交约定）

## 许可

本仓库的代码沿用 Mumble 的 BSD-3-Clause 许可。
Mumble 部分版权归 The Mumble Developers 所有，详见 Mumble 源码树的 `LICENSE`。
