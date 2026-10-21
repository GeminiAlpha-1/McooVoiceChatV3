// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/event_contracts.h"

#include <algorithm>

namespace moo {

void EventContractRegistry::define(const EventContract &contract) {
	if (contract.event.isEmpty()) {
		throw EventContractError(QStringLiteral("事件名不能为空"));
	}

	if (m_contracts.contains(contract.event)) {
		throw EventContractError(QStringLiteral("事件 '%1' 的契约被重复登记").arg(contract.event));
	}

	if (contract.publisherId.isEmpty()) {
		throw EventContractError(QStringLiteral("事件 '%1' 缺少唯一发布方").arg(contract.event));
	}

	m_contracts.insert(contract.event, contract);
}

void EventContractRegistry::undefine(const QString &event) {
	m_contracts.remove(event);
}

bool EventContractRegistry::isDefined(const QString &event) const {
	return m_contracts.contains(event);
}

const EventContract *EventContractRegistry::contract(const QString &event) const {
	const auto it = m_contracts.constFind(event);
	return it == m_contracts.constEnd() ? nullptr : &it.value();
}

bool EventContractRegistry::validatePublisher(const QString &event, const QString &publisherId) const {
	const EventContract *c = contract(event);
	if (c == nullptr) {
		return true;
	}
	return c->publisherId == publisherId;
}

bool EventContractRegistry::validateConsumer(const QString &event, const QString &consumerId) const {
	const EventContract *c = contract(event);
	if (c == nullptr) {
		return true;
	}
	return c->allowedConsumers.contains(consumerId);
}

bool EventContractRegistry::validatePayload(const QString &event, const QVariant &payload) const {
	const EventContract *c = contract(event);
	if (c == nullptr || !c->validator) {
		return true;
	}
	return c->validator(payload);
}

QStringList EventContractRegistry::events() const {
	QStringList result = m_contracts.keys();
	result.sort();
	return result;
}

} // namespace moo
