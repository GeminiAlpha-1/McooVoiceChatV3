// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#pragma once

#include <QHash>
#include <QString>
#include <QStringList>
#include <QVariant>

#include <functional>
#include <stdexcept>

namespace moo {

/// 违反事件契约时抛出。
///
/// 契约违规是**编码错误**，不是运行时状况，必须让开发者看见，
/// 因此这里选择直接抛错而不是记录日志后继续。
class EventContractError : public std::runtime_error {
public:
	explicit EventContractError(const QString &message) : std::runtime_error(message.toStdString()) {}
};

/// 一个事件的契约。
///
/// 三件事必须同时写清楚，缺一不可：
/// 1. 唯一发布方 —— 别的模块不能发这个事件
/// 2. 允许消费者 —— 哪些模块可以订阅
/// 3. payload 校验 —— 结构与类型
struct EventContract {
	/// 事件名。命名规则：`域:事件名`（如 `room:connected`）。
	QString event;

	/// 唯一发布方的模块 ID。
	QString publisherId;

	/// 允许订阅该事件的模块 ID。空列表表示「暂无消费者」。
	QStringList allowedConsumers;

	/// payload 校验函数。返回 false 表示 payload 不合法。
	std::function< bool(const QVariant &) > validator;

	EventContract() = default;

	EventContract(QString eventName, QString publisher, QStringList consumers,
				  std::function< bool(const QVariant &) > validate = {})
		: event(std::move(eventName)), publisherId(std::move(publisher)), allowedConsumers(std::move(consumers)),
		  validator(std::move(validate)) {}
};

/// 事件契约登记表。
///
/// 契约由**发布方模块**在注册时声明，框架不预置任何事件——
/// 这样新增模块时不需要改 core/，判据「新增模块时 core/ 一行都不用改」才成立。
class EventContractRegistry {
public:
	/// 登记一个事件的契约。重复登记同一事件会抛错。
	void define(const EventContract &contract);

	/// 撤销某个事件的契约。用于模块加载失败时清理。
	void undefine(const QString &event);

	/// 该事件是否已登记契约。
	bool isDefined(const QString &event) const;

	/// 取某个事件的契约。未登记时返回 nullptr。
	const EventContract *contract(const QString &event) const;

	/// 校验发布方。未登记契约的事件不做限制。
	bool validatePublisher(const QString &event, const QString &publisherId) const;

	/// 校验消费者。未登记契约的事件不做限制。
	bool validateConsumer(const QString &event, const QString &consumerId) const;

	/// 校验 payload。未登记契约或契约没有校验函数时不做限制。
	bool validatePayload(const QString &event, const QVariant &payload) const;

	/// 已登记契约的全部事件名。
	QStringList events() const;

private:
	QHash< QString, EventContract > m_contracts;
};

} // namespace moo
