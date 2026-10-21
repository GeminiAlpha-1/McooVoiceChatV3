// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/event_bus.h"
#include "core/log.h"

#include <exception>

namespace moo {

Subscription EventBus::Scope::on(const QString &event, Handler handler) {
	return m_bus->on(event, m_ownerId, std::move(handler));
}

bool EventBus::Scope::publish(const QString &event, const QVariant &payload) {
	return m_bus->publish(event, payload, m_ownerId);
}

Subscription EventBus::on(const QString &event, const QString &consumerId, Handler handler) {
	if (!handler) {
		throw EventContractError(QStringLiteral("事件 '%1' 的订阅回调为空（消费者 %2）").arg(event, consumerId));
	}

	if (!m_contracts.validateConsumer(event, consumerId)) {
		const EventContract *c = m_contracts.contract(event);
		throw EventContractError(QStringLiteral("模块 '%1' 未经允许订阅事件 '%2'（发布方 %3）")
									 .arg(consumerId, event, c ? c->publisherId : QString()));
	}

	const int id = m_nextHandlerId++;
	m_handlers[event].append(Entry{ id, consumerId, std::move(handler) });

	return Subscription([this, event, id]() { removeHandler(event, id); });
}

bool EventBus::publish(const QString &event, const QVariant &payload, const QString &publisherId) {
	if (!m_contracts.validatePublisher(event, publisherId)) {
		const EventContract *c = m_contracts.contract(event);
		throw EventContractError(QStringLiteral("模块 '%1' 不是事件 '%2' 的发布方（唯一发布方是 %3）")
									 .arg(publisherId, event, c ? c->publisherId : QString()));
	}

	if (!m_contracts.validatePayload(event, payload)) {
		throw EventContractError(
			QStringLiteral("事件 '%2' 的 payload 不符合契约（发布方 %1）").arg(publisherId, event));
	}

	// 复制一份再遍历：handler 内部可能退订自己
	const auto handlers = m_handlers.value(event);
	for (const Entry &entry : handlers) {
		try {
			entry.handler(payload);
		} catch (const std::exception &e) {
			log::error(QStringLiteral("事件 '%1' 的处理者（模块 %2，发布方 %3）抛出异常: %4")
						   .arg(event, entry.consumerId, publisherId, QString::fromUtf8(e.what())));
		} catch (...) {
			log::error(QStringLiteral("事件 '%1' 的处理者（模块 %2，发布方 %3）抛出未知异常")
						   .arg(event, entry.consumerId, publisherId));
		}
	}

	return true;
}

int EventBus::subscriberCount(const QString &event) const {
	return m_handlers.value(event).size();
}

void EventBus::removeHandler(const QString &event, int id) {
	const auto it = m_handlers.find(event);
	if (it == m_handlers.end()) {
		return;
	}

	for (int i = 0; i < it->size(); ++i) {
		if (it->at(i).id == id) {
			it->removeAt(i);
			break;
		}
	}

	if (it->isEmpty()) {
		m_handlers.erase(it);
	}
}

} // namespace moo
