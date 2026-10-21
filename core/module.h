// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#pragma once

#include "core/event_bus.h"
#include "core/event_contracts.h"
#include "core/store.h"
#include "core/subscription.h"

#include <QHash>
#include <QList>
#include <QObject>
#include <QString>
#include <QVariant>

#include <functional>
#include <memory>

class QTimer;

namespace moo {

/// 模块的运行环境。
///
/// 模块只从这里拿能力，不直接认识 Mumble 的内部 API——
/// 需要什么能力，由 services/ 适配层以 QObject 的形式注册进来。
class ModuleContext {
public:
	ModuleContext(Store *store, EventBus *events) : m_store(store), m_events(events) {}

	Store *store() const { return m_store; }

	EventBus *events() const { return m_events; }

	/// 注册一个能力服务。
	void setService(const QString &name, QObject *service);

	/// 取一个能力服务。不存在时返回 nullptr。
	QObject *service(const QString &name) const;

	/// 已注册的能力服务名。
	QStringList serviceNames() const;

private:
	Store *m_store     = nullptr;
	EventBus *m_events = nullptr;
	QHash< QString, QObject * > m_services;
};

/// 功能模块基类。
///
/// 三条约定：
/// 1. 模块之间互不认识，通信只走 Store 的共享区、EventBus、Service API。
/// 2. 模块是异常隔离单元：init() 炸了不影响别人，handler 炸了不影响别的 handler。
/// 3. 生命周期内创建的一切都必须在 destroy() 前回收。
///
/// 生命周期由宿主驱动，入口都是**非虚**的：
/// initialize() / openPanel() / closePanel() / destroy()。
/// 模块要写自己的逻辑，去覆盖 init() / onPanelOpened() / onPanelClosed() 这三个钩子。
/// 之所以不把入口做成虚函数，是因为一旦子类覆盖时忘了调用基类，
/// 基类的资源回收就会被静默跳过——这类 bug 很难查。
class Module : public QObject {
	Q_OBJECT

public:
	explicit Module(const QString &id, const QString &displayName = QString(), QObject *parent = nullptr);
	~Module() override;

	/// 模块 ID。全局唯一，同时作为状态命名空间与事件发布方身份。
	QString id() const { return m_id; }

	/// 界面上的显示名。默认与 ID 相同。
	virtual QString displayName() const;

	/// 本模块发布的事件契约。
	///
	/// 框架不预置任何事件，契约由发布方自己声明——
	/// 这样新增模块时不需要改 core/。
	virtual QList< EventContract > eventContracts() const { return {}; }

	/// 宿主调用：注入运行环境并调用 init()。
	///
	/// init() 抛异常时由 ModuleManager 处理（跳过该模块，其它模块照常加载）。
	void initialize(ModuleContext &context);

	/// 宿主调用：面板打开。
	void openPanel();

	/// 宿主调用：面板关闭。
	void closePanel();

	/// 宿主调用：卸载。必须回收全部资源。
	void destroy();

	/// 读取本模块的私有状态。
	QVariant state(const QString &key) const;

	/// 写入本模块的私有状态。
	void setState(const QString &key, const QVariant &value);

	/// 写入跨模块共享区。
	void share(const QString &key, const QVariant &value);

	/// 读取跨模块共享区。
	QVariant shared(const QString &key) const;

	/// 以本模块身份订阅事件。订阅随模块存活。
	Subscription on(const QString &event, EventBus::Handler handler);

	/// 以本模块身份发布事件。违反契约时抛 EventContractError。
	///
	/// 名字不叫 emit：`emit` 是 Qt 的宏，会被预处理成空。
	bool publish(const QString &event, const QVariant &payload);

	/// 订阅本模块命名空间下的状态变化。订阅随模块存活。
	Subscription watch(const QString &key, Store::Watcher watcher);

	/// 延时执行一次。面板关闭后已排队的回调不会执行。
	void defer(int delayMs, std::function< void() > callback);

	/// 周期性执行。面板关闭后已排队的回调不会执行。
	void repeat(int intervalMs, std::function< void() > callback);

	/// 在下一个事件循环回合执行一次。
	void frame(std::function< void() > callback);

	/// 面板是否处于打开状态。
	bool isActive() const;

	/// 是否已被销毁。
	bool isDestroyed() const { return m_destroyed; }

protected:
	/// 初始化钩子。抛异常时该模块会被跳过，其它模块继续加载。
	virtual void init() {}

	/// 面板打开钩子。
	virtual void onPanelOpened() {}

	/// 面板关闭钩子。
	virtual void onPanelClosed() {}

	/// 当前运行环境。initialize() 之后才有效。
	ModuleContext *context() const { return m_context; }

private:
	void clearPanelResources();
	void clearModuleResources();
	void scheduleTimer(QTimer *timer, int intervalMs, bool singleShot, std::function< void() > callback);

	QString m_id;
	QString m_displayName;
	ModuleContext *m_context = nullptr;
	Store *m_store           = nullptr;
	EventBus *m_events       = nullptr;

	QList< QTimer * > m_timers;
	QList< Subscription > m_watchSubscriptions;
	QList< Subscription > m_eventSubscriptions;

	quint64 m_lifecycleVersion = 0;
	bool m_active              = false;
	bool m_destroyed           = false;
};

} // namespace moo
