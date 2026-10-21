// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/module.h"
#include "core/module_manager.h"

#include <QTest>

#include <stdexcept>

using namespace moo;

/// 记录生命周期钩子被调用的探针模块。
class ProbeModule : public Module {
public:
	ProbeModule(const QString &id, QList< EventContract > contracts = {}, const QString &displayName = QString())
		: Module(id, displayName), m_contracts(std::move(contracts)) {}

	QList< EventContract > eventContracts() const override { return m_contracts; }

	int initCount    = 0;
	bool panelOpened = false;
	bool panelClosed = false;

protected:
	void init() override { ++initCount; }

	void onPanelOpened() override { panelOpened = true; }

	void onPanelClosed() override { panelClosed = true; }

private:
	QList< EventContract > m_contracts;
};

class TestModule : public QObject {
	Q_OBJECT

private slots:
	void testIdAndDisplayName();
	void testStateIsNamespaced();
	void testSharedNamespace();
	void testWatchNotifiesOwnNamespace();
	void testEmitAndSubscribeAcrossModules();
	void testTimerOnlyRunsWhilePanelOpen();
	void testDestroyCancelsSubscriptions();
	void testPanelHooksAreCalled();
};

void TestModule::testIdAndDisplayName() {
	ProbeModule module(QString("jukebox"));
	QCOMPARE(module.id(), QString("jukebox"));
	// 没给显示名时跟 ID 一样。
	QCOMPARE(module.displayName(), QString("jukebox"));

	ProbeModule named(QString("jukebox"), {}, QString("点歌台"));
	QCOMPARE(named.displayName(), QString("点歌台"));
}

void TestModule::testStateIsNamespaced() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ProbeModule >(QString("alpha")));
	manager.registerModule(std::make_unique< ProbeModule >(QString("beta")));
	manager.initAll();

	Module *alpha = manager.module("alpha");
	Module *beta  = manager.module("beta");
	QVERIFY(alpha != nullptr);
	QVERIFY(beta != nullptr);

	alpha->setState("count", 3);
	QCOMPARE(alpha->state("count").toInt(), 3);
	QCOMPARE(store.get("alpha.count").toInt(), 3);

	// 另一个模块看不到别人的私有状态。
	QVERIFY(!beta->state("count").isValid());
}

void TestModule::testSharedNamespace() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ProbeModule >(QString("alpha")));
	manager.registerModule(std::make_unique< ProbeModule >(QString("beta")));
	manager.initAll();

	manager.module("alpha")->share("room", QString("大厅"));

	// 共享区对所有模块可见。
	QCOMPARE(manager.module("beta")->shared("room").toString(), QString("大厅"));
	QCOMPARE(store.get("shared.room").toString(), QString("大厅"));
}

void TestModule::testWatchNotifiesOwnNamespace() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ProbeModule >(QString("alpha")));
	manager.initAll();

	Module *alpha = manager.module("alpha");
	QStringList seen;
	alpha->watch("volume", [&seen](const QVariant &value, const QString &) { seen.append(value.toString()); });

	alpha->setState("volume", 11);
	QCOMPARE(seen, QStringList{ QString("11") });
}

void TestModule::testEmitAndSubscribeAcrossModules() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	// 契约由发布方自己声明：只有 publisher 能发，watcher 才能收。
	manager.registerModule(std::make_unique< ProbeModule >(
		QString("publisher"),
		QList< EventContract >{ EventContract("test:pong", "publisher", QStringList{ "watcher" }) }));
	manager.registerModule(std::make_unique< ProbeModule >(QString("watcher")));
	manager.initAll();

	int received = 0;
	manager.module("watcher")->on("test:pong", [&received](const QVariant &payload) { received = payload.toInt(); });

	QVERIFY(manager.module("publisher")->publish("test:pong", 42));
	QCOMPARE(received, 42);

	// 不是发布方就发不出去。
	QVERIFY_THROWS_EXCEPTION(EventContractError, manager.module("watcher")->publish("test:pong", 1));
}

void TestModule::testTimerOnlyRunsWhilePanelOpen() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ProbeModule >(QString("alpha")));
	manager.initAll();

	Module *alpha = manager.module("alpha");
	int fired     = 0;
	alpha->repeat(10, [&fired]() { ++fired; });

	// 面板没开，定时回调不执行。
	QTest::qWait(60);
	QCOMPARE(fired, 0);

	alpha->openPanel();
	QTest::qWait(60);
	QVERIFY(fired > 0);

	// 面板关闭后定时器被回收，回调不再触发。
	const int afterClose = fired;
	alpha->closePanel();
	QTest::qWait(60);
	QCOMPARE(fired, afterClose);
}

void TestModule::testDestroyCancelsSubscriptions() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	manager.registerModule(std::make_unique< ProbeModule >(QString("alpha")));
	manager.initAll();

	Module *alpha = manager.module("alpha");
	int called    = 0;
	alpha->on("free:event", [&called](const QVariant &) { ++called; });

	events.publish("free:event", 1, "publisher");
	QCOMPARE(called, 1);

	// 模块卸载时必须把订阅退掉，不能让回调打到已销毁的对象上。
	alpha->destroy();
	events.publish("free:event", 1, "publisher");
	QCOMPARE(called, 1);
}

void TestModule::testPanelHooksAreCalled() {
	Store store;
	EventBus events;
	ModuleManager manager(&store, &events);

	auto module        = std::make_unique< ProbeModule >(QString("alpha"));
	ProbeModule *probe = module.get();
	manager.registerModule(std::move(module));
	manager.initAll();

	QVERIFY(!probe->panelOpened);
	QVERIFY(!probe->panelClosed);

	probe->openPanel();
	QVERIFY(probe->panelOpened);
	QVERIFY(probe->isActive());

	probe->closePanel();
	QVERIFY(probe->panelClosed);
	QVERIFY(!probe->isActive());
}

QTEST_GUILESS_MAIN(TestModule)

#include "test_module.moc"
