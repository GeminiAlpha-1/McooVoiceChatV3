// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#pragma once

#include "core/event_bus.h"
#include "core/module.h"
#include "core/store.h"

#include <QObject>
#include <QString>
#include <QStringList>

#include <memory>
#include <unordered_map>

namespace moo {

/// 模块的注册与生命周期管理。
///
/// 职责：
/// - 按注册顺序加载模块，**一个模块 init() 抛异常不影响其它模块**
/// - 登记每个模块自己声明的事件契约
/// - 卸载时保证资源被回收
class ModuleManager : public QObject {
	Q_OBJECT

public:
	ModuleManager(Store *store, EventBus *events, QObject *parent = nullptr);

	/// 注册一个模块。
	///
	/// 事件契约在注册时登记——这样任何一个模块 init() 时去订阅别的事件，
	/// 都已经能被契约校验到。
	///
	/// 重复 ID 或契约冲突会抛 EventContractError。
	void registerModule(std::unique_ptr< Module > module);

	/// 初始化全部已注册模块。
	///
	/// init() 失败的模块会被记录并跳过，**其它模块继续加载**。
	void initAll();

	/// 卸载一个模块。destroy() 抛异常也会被记录，不影响其它模块。
	void unload(const QString &id);

	/// 卸载全部模块。
	void unloadAll();

	/// 取一个已加载的模块。找不到时返回 nullptr。
	Module *module(const QString &id) const;

	/// 已加载的模块 ID（按注册顺序）。
	QStringList moduleIds() const;

	/// 注册一个能力服务，所有模块都能通过 ModuleContext 取到。
	void setService(const QString &name, QObject *service);

signals:
	void moduleLoaded(const QString &id);
	void moduleUnloaded(const QString &id);

private:
	using ModuleMap = std::unordered_map< QString, std::unique_ptr< Module > >;

	void defineContracts(Module &module);
	void undefineContracts(Module &module);
	void dropFailedModule(const QString &id, ModuleMap::iterator it);

	Store *m_store     = nullptr;
	EventBus *m_events = nullptr;
	ModuleContext m_context;
	ModuleMap m_modules;
	QStringList m_order;
};

} // namespace moo
