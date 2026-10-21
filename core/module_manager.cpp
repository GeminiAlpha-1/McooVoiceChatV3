// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/module_manager.h"
#include "core/log.h"

#include <exception>

namespace moo {

ModuleManager::ModuleManager(Store *store, EventBus *events, QObject *parent)
	: QObject(parent), m_store(store), m_events(events), m_context(store, events) {
}

void ModuleManager::registerModule(std::unique_ptr< Module > module) {
	if (!module) {
		throw EventContractError(QStringLiteral("不能注册空模块"));
	}

	const QString id = module->id();
	if (id.isEmpty()) {
		throw EventContractError(QStringLiteral("模块 ID 不能为空"));
	}

	if (m_modules.find(id) != m_modules.end()) {
		throw EventContractError(QStringLiteral("模块 '%1' 重复注册").arg(id));
	}

	defineContracts(*module);

	m_modules.emplace(id, std::move(module));
	m_order.append(id);
}

void ModuleManager::initAll() {
	// 复制一份再遍历：循环体会把加载失败的模块从 m_order 里摘掉，
	// 直接遍历 m_order 会让迭代器失效。
	const QStringList order = m_order;

	for (const QString &id : order) {
		auto it = m_modules.find(id);
		if (it == m_modules.end()) {
			continue;
		}

		Module *module = it->second.get();
		try {
			module->initialize(m_context);
			log::warn(QStringLiteral("模块 '%1' (%2) 加载完成").arg(id, module->displayName()));
			emit moduleLoaded(id);
		} catch (const std::exception &e) {
			log::error(QStringLiteral("模块 '%1' 初始化失败: %2").arg(id, QString::fromUtf8(e.what())));
			dropFailedModule(id, it);
		} catch (...) {
			log::error(QStringLiteral("模块 '%1' 初始化抛出未知异常").arg(id));
			dropFailedModule(id, it);
		}
	}
}

void ModuleManager::unload(const QString &id) {
	auto it = m_modules.find(id);
	if (it == m_modules.end()) {
		return;
	}

	Module *module = it->second.get();
	try {
		module->destroy();
	} catch (const std::exception &e) {
		log::error(QStringLiteral("模块 '%1' 卸载失败: %2").arg(id, QString::fromUtf8(e.what())));
	} catch (...) {
		log::error(QStringLiteral("模块 '%1' 卸载时抛出未知异常").arg(id));
	}

	undefineContracts(*module);
	m_modules.erase(it);
	m_order.removeAll(id);
	emit moduleUnloaded(id);
}

void ModuleManager::unloadAll() {
	const QStringList ids = m_order;
	for (const QString &id : ids) {
		unload(id);
	}
}

Module *ModuleManager::module(const QString &id) const {
	const auto it = m_modules.find(id);
	return it == m_modules.end() ? nullptr : it->second.get();
}

QStringList ModuleManager::moduleIds() const {
	return m_order;
}

void ModuleManager::setService(const QString &name, QObject *service) {
	m_context.setService(name, service);
}

void ModuleManager::defineContracts(Module &module) {
	const QList< EventContract > contracts = module.eventContracts();
	QStringList defined;

	try {
		for (const EventContract &contract : contracts) {
			if (contract.publisherId != module.id()) {
				throw EventContractError(QStringLiteral("模块 '%1' 声明的事件 '%2' 的发布方写成了 '%3'，必须是自己")
											 .arg(module.id(), contract.event, contract.publisherId));
			}
			m_events->contracts().define(contract);
			defined.append(contract.event);
		}
	} catch (...) {
		// 回滚：不能留下指向一个没被注册成功的模块的契约。
		for (const QString &event : defined) {
			m_events->contracts().undefine(event);
		}
		throw;
	}
}

void ModuleManager::undefineContracts(Module &module) {
	const QList< EventContract > contracts = module.eventContracts();
	for (const EventContract &contract : contracts) {
		m_events->contracts().undefine(contract.event);
	}
}

void ModuleManager::dropFailedModule(const QString &id, ModuleMap::iterator it) {
	Module *module = it->second.get();

	// 失败的模块要回收掉已创建的资源，并撤销它登记的事件契约，
	// 否则会留下指向一个不存在的发布方的契约。
	try {
		module->destroy();
	} catch (const std::exception &e) {
		log::error(QStringLiteral("模块 '%1' 初始化失败后的清理也抛出了异常: %2").arg(id, QString::fromUtf8(e.what())));
	} catch (...) {
		log::error(QStringLiteral("模块 '%1' 初始化失败后的清理也抛出了未知异常").arg(id));
	}

	undefineContracts(*module);
	m_modules.erase(it);
	m_order.removeAll(id);
}

} // namespace moo
