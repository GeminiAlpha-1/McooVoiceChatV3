// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#pragma once

#include "core/event_contracts.h"
#include "core/subscription.h"

#include <QHash>
#include <QList>
#include <QString>
#include <QVariant>

#include <functional>

namespace moo {

/// 事件总线。
///
/// 两条硬规矩：
/// 1. **事件必须有契约** —— 发布方、消费者、payload 三者由 EventContractRegistry 约束，
///    违规直接抛 EventContractError。
/// 2. **handler 异常隔离** —— 某个订阅者炸了，其它订阅者照常收到事件，
///    失败会被记录（事件名 / 发布方 / 消费者 / 异常内容），绝不静默吞错。
class EventBus {
public:
	using Handler = std::function< void(const QVariant &payload) >;

	/// 事件总线的**受限视图**。
	///
	/// 模块拿到的不是总线本身，而是绑定了自己 ID 的视图：
	/// 它只能以自己的身份发布事件，也只能以自己的身份订阅。
	/// 这样「唯一发布方」在结构上就成立，不依赖调用方自觉。
	class Scope {
	public:
		Scope(EventBus *bus, QString ownerId) : m_bus(bus), m_ownerId(std::move(ownerId)) {}

		/// 以本模块身份订阅事件。未被契约允许时抛 EventContractError。
		Subscription on(const QString &event, Handler handler);

		/// 以本模块身份发布事件。发布方或 payload 违反契约时抛 EventContractError。
		///
		/// 名字不叫 emit：`emit` 是 Qt 的宏，会被预处理成空。
		bool publish(const QString &event, const QVariant &payload);

		const QString &ownerId() const { return m_ownerId; }

	private:
		EventBus *m_bus;
		QString m_ownerId;
	};

	EventBus() = default;

	/// 契约登记表。模块注册时由 ModuleManager 往这里登记自己发布的事件。
	EventContractRegistry &contracts() { return m_contracts; }
	const EventContractRegistry &contracts() const { return m_contracts; }

	/// 取某个模块 ID 的受限视图。
	Scope scope(const QString &ownerId) { return Scope(this, ownerId); }

	/// 以指定消费者身份订阅事件。未被契约允许时抛 EventContractError。
	Subscription on(const QString &event, const QString &consumerId, Handler handler);

	/// 以指定发布方身份发布事件。发布方或 payload 违反契约时抛 EventContractError。
	///
	/// 返回 true 表示事件已被发出（无论有没有订阅者）。
	bool publish(const QString &event, const QVariant &payload, const QString &publisherId);

	/// 某个事件当前的订阅者数量。
	int subscriberCount(const QString &event) const;

private:
	struct Entry {
		int id;
		QString consumerId;
		Handler handler;
	};

	void removeHandler(const QString &event, int id);

	QHash< QString, QList< Entry > > m_handlers;
	EventContractRegistry m_contracts;
	int m_nextHandlerId = 1;
};

} // namespace moo
