// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/event_bus.h"

#include <QMetaType>
#include <QTest>

#include <stdexcept>

using namespace moo;

class TestEventBus : public QObject {
	Q_OBJECT

private slots:
	void testUncontractedEventIsFree();
	void testOnlyPublisherMayEmit();
	void testOnlyAllowedConsumerMaySubscribe();
	void testPayloadValidatorRejectsBadPayload();
	void testHandlerExceptionIsIsolated();
	void testUnsubscribeStopsDelivery();
	void testScopeUsesOwnerIdentity();
	void testHandlerMayUnsubscribeItself();
};

void TestEventBus::testUncontractedEventIsFree() {
	EventBus bus;
	int called = 0;

	Subscription subscription = bus.on("free:event", "consumer", [&called](const QVariant &) { ++called; });

	QVERIFY(bus.publish("free:event", 1, "publisher"));
	QCOMPARE(called, 1);
	QVERIFY(subscription.isActive());
}

void TestEventBus::testOnlyPublisherMayEmit() {
	EventBus bus;
	bus.contracts().define(EventContract("room:joined", "room", QStringList{ "ui" }));

	// 别的模块不能发这个事件。
	QVERIFY_THROWS_EXCEPTION(EventContractError, bus.publish("room:joined", 1, "other"));
	QVERIFY(bus.publish("room:joined", 1, "room"));
}

void TestEventBus::testOnlyAllowedConsumerMaySubscribe() {
	EventBus bus;
	bus.contracts().define(EventContract("room:joined", "room", QStringList{ "ui" }));

	QVERIFY_THROWS_EXCEPTION(EventContractError, bus.on("room:joined", "rogue", [](const QVariant &) {}));

	Subscription subscription = bus.on("room:joined", "ui", [](const QVariant &) {});
	QVERIFY(subscription.isActive());
	QCOMPARE(bus.subscriberCount("room:joined"), 1);
}

void TestEventBus::testPayloadValidatorRejectsBadPayload() {
	EventBus bus;
	bus.contracts().define(EventContract("room:joined", "room", QStringList{ "ui" },
										 [](const QVariant &payload) { return payload.typeId() == QMetaType::Int; }));

	QVERIFY_THROWS_EXCEPTION(EventContractError, bus.publish("room:joined", QString("nope"), "room"));
	QVERIFY(bus.publish("room:joined", 42, "room"));
}

void TestEventBus::testHandlerExceptionIsIsolated() {
	EventBus bus;
	int good = 0;

	Subscription bad = bus.on("e", "bad", [](const QVariant &) { throw std::runtime_error("boom"); });
	Subscription ok  = bus.on("e", "good", [&good](const QVariant &) { ++good; });

	// 炸掉的 handler 不能影响其它 handler。
	bus.publish("e", 1, "publisher");
	QCOMPARE(good, 1);
}

void TestEventBus::testUnsubscribeStopsDelivery() {
	EventBus bus;
	int called = 0;

	Subscription subscription = bus.on("e", "consumer", [&called](const QVariant &) { ++called; });
	QCOMPARE(bus.subscriberCount("e"), 1);

	bus.publish("e", 1, "publisher");
	QCOMPARE(called, 1);

	subscription.cancel();
	QVERIFY(!subscription.isActive());
	QCOMPARE(bus.subscriberCount("e"), 0);

	bus.publish("e", 1, "publisher");
	QCOMPARE(called, 1);
}

void TestEventBus::testScopeUsesOwnerIdentity() {
	EventBus bus;
	bus.contracts().define(EventContract("room:joined", "room", QStringList{ "ui" }));
	int called = 0;

	Subscription subscription = bus.scope("ui").on("room:joined", [&called](const QVariant &) { ++called; });

	// scope 里的发布方身份就是 scope 绑定的 ID。
	QVERIFY(bus.scope("room").publish("room:joined", 1));
	QCOMPARE(called, 1);

	// 身份不对就发不出去。
	QVERIFY_THROWS_EXCEPTION(EventContractError, bus.scope("ui").publish("room:joined", 1));
}

void TestEventBus::testHandlerMayUnsubscribeItself() {
	EventBus bus;
	int called = 0;

	Subscription subscription;
	subscription = bus.on("e", "consumer", [&called, &subscription](const QVariant &) {
		++called;
		subscription.cancel();
	});

	bus.publish("e", 1, "publisher");
	QCOMPARE(called, 1);
	QCOMPARE(bus.subscriberCount("e"), 0);

	bus.publish("e", 1, "publisher");
	QCOMPARE(called, 1);
}

QTEST_GUILESS_MAIN(TestEventBus)

#include "test_event_bus.moc"
