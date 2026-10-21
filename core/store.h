// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#pragma once

#include "core/subscription.h"

#include <QHash>
#include <QList>
#include <QString>
#include <QVariant>

#include <functional>

namespace moo {

/// 跨模块共享的状态存储。
///
/// 键是点分路径（`room.name`、`shared.jukebox.queue`）。
/// 存储是扁平的：路径整体作为键，不拆成嵌套对象——扁平键让通配订阅
/// 与路径前缀判断都变成简单的字符串操作。
///
/// 订阅路径可以以 `.*` 结尾，表示前缀通配：
/// 订阅 `room.*` 会在 `room.name` 被写入时收到通知，subPath 为 `name`。
class Store {
public:
	/// 状态变化回调。subPath 是相对订阅路径的剩余部分，通配订阅时才非空。
	using Watcher = std::function< void(const QVariant &value, const QString &subPath) >;

	/// 读取某个路径的值。路径不存在时返回无效的 QVariant。
	QVariant get(const QString &path) const;

	/// 写入某个路径的值，并通知订阅者。
	///
	/// 订阅者抛异常不会影响写入本身，但会被记录下来。
	void set(const QString &path, const QVariant &value);

	/// 订阅某个路径（支持 `.*` 前缀通配）。
	Subscription watch(const QString &path, Watcher watcher);

	/// 路径上是否已有值。
	bool contains(const QString &path) const;

	/// 删除某个路径上的值并通知订阅者。
	void remove(const QString &path);

	/// 清空所有值与订阅。
	void clear();

private:
	struct WatchEntry {
		int id;
		Watcher watcher;
	};

	void notify(const QString &path, const QVariant &value);
	void removeWatcher(const QString &path, int id);

	QHash< QString, QVariant > m_values;
	QHash< QString, QList< WatchEntry > > m_watchers;
	int m_nextWatcherId = 1;
};

} // namespace moo
