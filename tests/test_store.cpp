// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/store.h"

#include <QTest>

#include <stdexcept>

using namespace moo;

class TestStore : public QObject {
	Q_OBJECT

private slots:
	void testSetGet();
	void testContainsAndRemove();
	void testWatchExactPath();
	void testWatchWildcardPrefix();
	void testWatchGlobalWildcard();
	void testWatchUnsubscribe();
	void testWatcherExceptionIsIsolated();
	void testClear();
};

void TestStore::testSetGet() {
	Store store;
	QVERIFY(!store.contains("room.name"));
	QVERIFY(!store.get("room.name").isValid());

	store.set("room.name", QString("大厅"));
	QVERIFY(store.contains("room.name"));
	QCOMPARE(store.get("room.name").toString(), QString("大厅"));
}

void TestStore::testContainsAndRemove() {
	Store store;
	store.set("a", 1);
	QVERIFY(store.contains("a"));

	store.remove("a");
	QVERIFY(!store.contains("a"));
	QVERIFY(!store.get("a").isValid());

	// 删不存在的路径不该出事。
	store.remove("a");
}

void TestStore::testWatchExactPath() {
	Store store;
	QStringList seen;
	QStringList subPaths;

	Subscription subscription =
		store.watch("room.name", [&seen, &subPaths](const QVariant &value, const QString &subPath) {
			seen.append(value.toString());
			subPaths.append(subPath);
		});

	store.set("room.name", QString("A"));
	store.set("room.name", QString("B"));
	store.set("room.other", QString("C"));

	QCOMPARE(seen, QStringList({ QString("A"), QString("B") }));
	// 精确匹配的 subPath 为空。
	QVERIFY(subPaths.at(0).isEmpty());
	QVERIFY(subPaths.at(1).isEmpty());
	QVERIFY(subscription.isActive());
}

void TestStore::testWatchWildcardPrefix() {
	Store store;
	QStringList subPaths;

	Subscription subscription =
		store.watch("room.*", [&subPaths](const QVariant &, const QString &subPath) { subPaths.append(subPath); });

	store.set("room.name", QString("A"));
	store.set("room.volume", 3);
	store.set("other.name", QString("B"));

	// 只有 room.* 前缀的两次写入会命中，subPath 是相对前缀的剩余部分。
	QCOMPARE(subPaths, QStringList({ QString("name"), QString("volume") }));
}

void TestStore::testWatchGlobalWildcard() {
	Store store;
	QStringList subPaths;

	Subscription subscription =
		store.watch("*", [&subPaths](const QVariant &, const QString &subPath) { subPaths.append(subPath); });

	store.set("room.name", QString("A"));
	store.set("shared.volume", 3);

	// 全局通配收到整条路径。
	QCOMPARE(subPaths, QStringList({ QString("room.name"), QString("shared.volume") }));
}

void TestStore::testWatchUnsubscribe() {
	Store store;
	int count = 0;

	Subscription subscription = store.watch("a", [&count](const QVariant &, const QString &) { ++count; });

	store.set("a", 1);
	QCOMPARE(count, 1);

	subscription.cancel();
	QVERIFY(!subscription.isActive());

	store.set("a", 2);
	QCOMPARE(count, 1);
}

void TestStore::testWatcherExceptionIsIsolated() {
	Store store;
	int good = 0;

	Subscription bad = store.watch("x", [](const QVariant &, const QString &) { throw std::runtime_error("boom"); });
	Subscription ok  = store.watch("x", [&good](const QVariant &, const QString &) { ++good; });

	// 订阅者抛异常不能打断写入，也不能影响其它订阅者。
	store.set("x", 1);
	QCOMPARE(good, 1);
}

void TestStore::testClear() {
	Store store;
	int count = 0;

	Subscription subscription = store.watch("a", [&count](const QVariant &, const QString &) { ++count; });

	store.set("a", 1);
	QCOMPARE(count, 1);

	store.clear();
	QVERIFY(!store.contains("a"));

	store.set("a", 2);
	// clear 把订阅也清了，不该再收到通知。
	QCOMPARE(count, 1);
}

QTEST_GUILESS_MAIN(TestStore)

#include "test_store.moc"
