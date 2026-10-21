// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/module_manager.h"

#include <QObject>
#include <QTest>

#include <stdexcept>

using namespace moo;

/// 可配置的测试模块：能带契约、也能故意在 init 时炸掉。
class ConfigurableModule : public Module {
public:
	ConfigurableModule(const QString &id, QList< EventContract > contracts = {}, bool failOnInit = false)
		: Module(id), m_contracts(std::move(contracts)), m_failOnInit(failOnInit) {}

	QList< EventContract > eventContracts() const override { return m_contracts; }

	/// 测试用：把受保护的 context() 暴露出来，好验证服务注入链路。
	ModuleContext *moduleContext() const { return context(); }

	bool initCalled = false;

protected:
	void init() override {
		initCalled = true;
		if (m_failOnInit) {
			throw std::runtime_error("init failed on purpose");
		}
	}

private:
	QList< EventContract > m_contracts;
	bool m_failOnInit = false;
};

class TestModuleManager : public QObject {
	Q_OBJECT

private slots:
	void testRegisterRejectsDuplicateId();
	void testRegisterRejectsForeignPublisher();
	void testRegisterConflictRollsBackContracts();
	void testInitFailureSkipsOnlyThatModule();
	void testInitFailureUndefinesContracts();
	void testUnloadRemovesModuleAndContract();
	void testModuleIdsKeepRegistrationOrder();
	void testServicesAreReachable();
};

void TestModuleManager::testRegisterRejectsDuplicateId() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ConfigurableModule >(QString("alpha")));
	QVERIFY_THROWS_EXCEPTION(EventContractError,
							 manager.registerModule(std::make_unique< ConfigurableModule >(QString("alpha"))));

	QCOMPARE(manager.moduleIds(), QStringList{ QString("alpha") });
}

void TestModuleManager::testRegisterRejectsForeignPublisher() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	// 模块不能替别人声明事件。
	QVERIFY_THROWS_EXCEPTION(
		EventContractError,
		manager.registerModule(std::make_unique< ConfigurableModule >(
			QString("alpha"), QList< EventContract >{ EventContract("e:one", "beta", QStringList{ "alpha" }) })));

	QVERIFY(!events.contracts().isDefined("e:one"));
	QVERIFY(manager.moduleIds().isEmpty());
}

void TestModuleManager::testRegisterConflictRollsBackContracts() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ConfigurableModule >(
		QString("beta"), QList< EventContract >{ EventContract("e:two", "beta", QStringList{ "beta" }) }));

	// e:two 已经被 beta 占了，alpha 声明同名事件必须失败，
	// 并且已经登记成功的 e:one 要回滚掉，不能留下悬空契约。
	QVERIFY_THROWS_EXCEPTION(
		EventContractError,
		manager.registerModule(std::make_unique< ConfigurableModule >(
			QString("alpha"), QList< EventContract >{ EventContract("e:one", "alpha", QStringList{ "alpha" }),
													  EventContract("e:two", "alpha", QStringList{ "alpha" }) })));

	QVERIFY(!events.contracts().isDefined("e:one"));
	QVERIFY(events.contracts().isDefined("e:two"));
}

void TestModuleManager::testInitFailureSkipsOnlyThatModule() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ConfigurableModule >(QString("bad"), QList< EventContract >{}, true));
	manager.registerModule(std::make_unique< ConfigurableModule >(QString("good")));

	// 坏模块炸了不能连累好模块。
	manager.initAll();

	QVERIFY(manager.module("bad") == nullptr);
	QVERIFY(manager.module("good") != nullptr);
	QCOMPARE(manager.moduleIds(), QStringList{ QString("good") });
}

void TestModuleManager::testInitFailureUndefinesContracts() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ConfigurableModule >(
		QString("bad"), QList< EventContract >{ EventContract("e:one", "bad", QStringList{ "bad" }) }, true));

	manager.initAll();

	// 模块没了，契约也得撤掉——否则会留下指向不存在发布方的契约。
	QVERIFY(!events.contracts().isDefined("e:one"));
}

void TestModuleManager::testUnloadRemovesModuleAndContract() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ConfigurableModule >(
		QString("alpha"), QList< EventContract >{ EventContract("e:one", "alpha", QStringList{ "alpha" }) }));
	manager.initAll();

	QVERIFY(manager.module("alpha") != nullptr);
	QVERIFY(events.contracts().isDefined("e:one"));

	manager.unload("alpha");

	QVERIFY(manager.module("alpha") == nullptr);
	QVERIFY(!events.contracts().isDefined("e:one"));
	QVERIFY(manager.moduleIds().isEmpty());
}

void TestModuleManager::testModuleIdsKeepRegistrationOrder() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ConfigurableModule >(QString("c")));
	manager.registerModule(std::make_unique< ConfigurableModule >(QString("a")));
	manager.registerModule(std::make_unique< ConfigurableModule >(QString("b")));

	QCOMPARE(manager.moduleIds(), QStringList({ QString("c"), QString("a"), QString("b") }));
}

void TestModuleManager::testServicesAreReachable() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	QObject service;
	manager.setService("audio", &service);

	manager.registerModule(std::make_unique< ConfigurableModule >(QString("alpha")));
	manager.initAll();

	// 模块通过 context() 拿服务，不直接认识 Mumble 的内部 API。
	auto *alpha = static_cast< ConfigurableModule * >(manager.module("alpha"));
	QVERIFY(alpha != nullptr);
	QVERIFY(alpha->moduleContext() != nullptr);
	QCOMPARE(alpha->moduleContext()->service("audio"), &service);
	QVERIFY(alpha->moduleContext()->service("missing") == nullptr);
}

QTEST_GUILESS_MAIN(TestModuleManager)

#include "test_module_manager.moc"
