// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/event_contracts.h"

#include <QMetaType>
#include <QTest>

using namespace moo;

class TestEventContracts : public QObject {
	Q_OBJECT

private slots:
	void testDefineAndUndefine();
	void testDefineDuplicateThrows();
	void testDefineEmptyEventThrows();
	void testDefineEmptyPublisherThrows();
	void testValidatePublisher();
	void testValidateConsumer();
	void testValidatePayload();
	void testEventsAreSorted();
};

void TestEventContracts::testDefineAndUndefine() {
	EventContractRegistry registry;
	QVERIFY(!registry.isDefined("room:joined"));

	registry.define(EventContract("room:joined", "room", QStringList{ "ui" }));
	QVERIFY(registry.isDefined("room:joined"));

	const EventContract *contract = registry.contract("room:joined");
	QVERIFY(contract != nullptr);
	QCOMPARE(contract->publisherId, QString("room"));
	QCOMPARE(contract->allowedConsumers, QStringList{ "ui" });

	registry.undefine("room:joined");
	QVERIFY(!registry.isDefined("room:joined"));
	QVERIFY(registry.contract("room:joined") == nullptr);
}

void TestEventContracts::testDefineDuplicateThrows() {
	EventContractRegistry registry;
	registry.define(EventContract("room:joined", "room", QStringList{ "ui" }));

	QVERIFY_THROWS_EXCEPTION(EventContractError, registry.define(EventContract("room:joined", "other", QStringList{})));
}

void TestEventContracts::testDefineEmptyEventThrows() {
	EventContractRegistry registry;
	QVERIFY_THROWS_EXCEPTION(EventContractError, registry.define(EventContract(QString(), "room", QStringList{})));
}

void TestEventContracts::testDefineEmptyPublisherThrows() {
	EventContractRegistry registry;
	QVERIFY_THROWS_EXCEPTION(EventContractError,
							 registry.define(EventContract("room:joined", QString(), QStringList{})));
}

void TestEventContracts::testValidatePublisher() {
	EventContractRegistry registry;
	registry.define(EventContract("room:joined", "room", QStringList{ "ui" }));

	QVERIFY(registry.validatePublisher("room:joined", "room"));
	QVERIFY(!registry.validatePublisher("room:joined", "other"));

	// 没登记契约的事件不做限制。
	QVERIFY(registry.validatePublisher("free:event", "anyone"));
}

void TestEventContracts::testValidateConsumer() {
	EventContractRegistry registry;
	registry.define(EventContract("room:joined", "room", QStringList{ "ui", "jukebox" }));

	QVERIFY(registry.validateConsumer("room:joined", "ui"));
	QVERIFY(registry.validateConsumer("room:joined", "jukebox"));
	QVERIFY(!registry.validateConsumer("room:joined", "rogue"));

	QVERIFY(registry.validateConsumer("free:event", "anyone"));
}

void TestEventContracts::testValidatePayload() {
	EventContractRegistry registry;
	registry.define(EventContract("room:joined", "room", QStringList{ "ui" },
								  [](const QVariant &payload) { return payload.typeId() == QMetaType::Int; }));

	QVERIFY(registry.validatePayload("room:joined", 42));
	QVERIFY(!registry.validatePayload("room:joined", QString("nope")));

	// 没登记契约、或契约没写校验函数时不做限制。
	QVERIFY(registry.validatePayload("free:event", QString("anything")));

	EventContractRegistry plain;
	plain.define(EventContract("room:left", "room", QStringList{ "ui" }));
	QVERIFY(plain.validatePayload("room:left", QString("anything")));
}

void TestEventContracts::testEventsAreSorted() {
	EventContractRegistry registry;
	registry.define(EventContract("room:joined", "room", QStringList{}));
	registry.define(EventContract("jukebox:added", "jukebox", QStringList{}));
	registry.define(EventContract("app:ready", "app", QStringList{}));

	QCOMPARE(registry.events(),
			 QStringList({ QString("app:ready"), QString("jukebox:added"), QString("room:joined") }));
}

QTEST_GUILESS_MAIN(TestEventContracts)

#include "test_event_contracts.moc"
