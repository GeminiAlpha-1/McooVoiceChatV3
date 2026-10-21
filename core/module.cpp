// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/module.h"
#include "core/log.h"

#include <QTimer>

#include <algorithm>
#include <exception>

namespace moo {

void ModuleContext::setService(const QString &name, QObject *service) {
	m_services.insert(name, service);
}

QObject *ModuleContext::service(const QString &name) const {
	return m_services.value(name, nullptr);
}

QStringList ModuleContext::serviceNames() const {
	QStringList names = m_services.keys();
	names.sort();
	return names;
}

Module::Module(const QString &id, const QString &displayName, QObject *parent) : QObject(parent), m_id(id) {
	m_displayName = displayName.isEmpty() ? id : displayName;
}

Module::~Module() {
	// 析构兜底：正常路径下 destroy() 已经清过一遍，
	// 这里再清一次是为了防止调用方漏调 destroy()。
	clearModuleResources();
}

QString Module::displayName() const {
	return m_displayName;
}

void Module::initialize(ModuleContext &context) {
	m_context = &context;
	m_store   = context.store();
	m_events  = context.events();
	init();
}

void Module::openPanel() {
	if (m_destroyed) {
		return;
	}
	m_active = true;
	onPanelOpened();
}

void Module::closePanel() {
	if (!m_active) {
		return;
	}
	m_active = false;
	// 先回收面板资源，再让模块做自己的收尾。
	clearPanelResources();
	onPanelClosed();
}

void Module::destroy() {
	if (m_destroyed) {
		return;
	}
	closePanel();
	m_destroyed = true;
	clearModuleResources();
}

QVariant Module::state(const QString &key) const {
	if (m_store == nullptr) {
		return QVariant();
	}
	return m_store->get(m_id + QLatin1Char('.') + key);
}

void Module::setState(const QString &key, const QVariant &value) {
	if (m_store == nullptr) {
		return;
	}
	m_store->set(m_id + QLatin1Char('.') + key, value);
}

void Module::share(const QString &key, const QVariant &value) {
	if (m_store == nullptr) {
		return;
	}
	m_store->set(QStringLiteral("shared.") + key, value);
}

QVariant Module::shared(const QString &key) const {
	if (m_store == nullptr) {
		return QVariant();
	}
	return m_store->get(QStringLiteral("shared.") + key);
}

Subscription Module::on(const QString &event, EventBus::Handler handler) {
	if (m_events == nullptr) {
		return Subscription();
	}
	Subscription subscription = m_events->scope(m_id).on(event, std::move(handler));
	// 模块留一份，调用方拿到的句柄与之共享同一次订阅。
	m_eventSubscriptions.append(subscription);
	return subscription;
}

bool Module::publish(const QString &event, const QVariant &payload) {
	if (m_events == nullptr) {
		return false;
	}
	return m_events->scope(m_id).publish(event, payload);
}

Subscription Module::watch(const QString &key, Store::Watcher watcher) {
	if (m_store == nullptr) {
		return Subscription();
	}
	Subscription subscription = m_store->watch(m_id + QLatin1Char('.') + key, std::move(watcher));
	m_watchSubscriptions.append(subscription);
	return subscription;
}

void Module::defer(int delayMs, std::function< void() > callback) {
	scheduleTimer(new QTimer(this), delayMs, true, std::move(callback));
}

void Module::repeat(int intervalMs, std::function< void() > callback) {
	scheduleTimer(new QTimer(this), intervalMs, false, std::move(callback));
}

void Module::frame(std::function< void() > callback) {
	scheduleTimer(new QTimer(this), 0, true, std::move(callback));
}

bool Module::isActive() const {
	return m_active && !m_destroyed;
}

void Module::scheduleTimer(QTimer *timer, int intervalMs, bool singleShot, std::function< void() > callback) {
	if (!callback) {
		delete timer;
		return;
	}

	// 记录排队时的生命周期版本：面板关闭会自增版本号，
	// 版本对不上的回调说明它属于已经关闭的那一轮面板，直接丢弃。
	const quint64 version = m_lifecycleVersion;

	timer->setSingleShot(singleShot);
	timer->setInterval(std::max(0, intervalMs));
	m_timers.append(timer);

	QObject::connect(timer, &QTimer::timeout, this, [this, timer, version, callback]() {
		if (timer->isSingleShot()) {
			m_timers.removeAll(timer);
			timer->deleteLater();
		}
		// 面板没打开就不执行：定时器是面板作用域的资源，
		// 模块在面板关闭期间处于停工状态。
		if (m_destroyed || !m_active || version != m_lifecycleVersion) {
			return;
		}
		try {
			callback();
		} catch (const std::exception &e) {
			log::error(QStringLiteral("模块 '%1' 的定时回调抛出异常: %2").arg(m_id, QString::fromUtf8(e.what())));
		} catch (...) {
			log::error(QStringLiteral("模块 '%1' 的定时回调抛出未知异常").arg(m_id));
		}
	});

	timer->start();
}

void Module::clearPanelResources() {
	// 自增版本号，让已经排队但还没执行的回调失效。
	++m_lifecycleVersion;

	for (QTimer *timer : m_timers) {
		timer->stop();
		timer->deleteLater();
	}
	m_timers.clear();
}

void Module::clearModuleResources() {
	clearPanelResources();

	// 显式退订：只清容器的话，调用方持有的那份句柄还会让订阅继续活着。
	for (Subscription &subscription : m_watchSubscriptions) {
		subscription.cancel();
	}
	m_watchSubscriptions.clear();

	for (Subscription &subscription : m_eventSubscriptions) {
		subscription.cancel();
	}
	m_eventSubscriptions.clear();

	m_context = nullptr;
	m_store   = nullptr;
	m_events  = nullptr;
}

} // namespace moo
