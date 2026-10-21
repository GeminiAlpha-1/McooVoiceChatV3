// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/store.h"
#include "core/log.h"

#include <QStringList>

#include <exception>

namespace moo {

QVariant Store::get(const QString &path) const {
	return m_values.value(path);
}

bool Store::contains(const QString &path) const {
	return m_values.contains(path);
}

void Store::set(const QString &path, const QVariant &value) {
	m_values.insert(path, value);
	notify(path, value);
}

void Store::remove(const QString &path) {
	if (!m_values.contains(path)) {
		return;
	}
	m_values.remove(path);
	notify(path, QVariant());
}

void Store::clear() {
	m_values.clear();
	m_watchers.clear();
}

Subscription Store::watch(const QString &path, Watcher watcher) {
	if (!watcher) {
		return Subscription();
	}

	const int id = m_nextWatcherId++;
	m_watchers[path].append(WatchEntry{ id, watcher });

	return Subscription([this, path, id]() { removeWatcher(path, id); });
}

void Store::removeWatcher(const QString &path, int id) {
	const auto it = m_watchers.find(path);
	if (it == m_watchers.end()) {
		return;
	}

	for (int i = 0; i < it->size(); ++i) {
		if (it->at(i).id == id) {
			it->removeAt(i);
			break;
		}
	}

	if (it->isEmpty()) {
		m_watchers.erase(it);
	}
}

void Store::notify(const QString &path, const QVariant &value) {
	// 精确匹配
	const auto exact = m_watchers.value(path);
	for (const WatchEntry &entry : exact) {
		try {
			entry.watcher(value, QString());
		} catch (const std::exception &e) {
			log::error(QStringLiteral("Store 订阅者处理 '%1' 时抛出异常: %2").arg(path, QString::fromUtf8(e.what())));
		} catch (...) {
			log::error(QStringLiteral("Store 订阅者处理 '%1' 时抛出未知异常").arg(path));
		}
	}

	// 前缀通配：`a.b.c` 依次匹配 `a.b.*`（subPath `c`）、`a.*`（subPath `b.c`）、`*`（subPath 整条路径）
	const QStringList parts = path.split(QLatin1Char('.'));
	for (int i = parts.size() - 1; i >= 0; --i) {
		QString wildcard;
		QString subPath;
		if (i == 0) {
			// 最外层通配是 `*`，覆盖所有路径。
			wildcard = QStringLiteral("*");
			subPath  = path;
		} else {
			wildcard = parts.mid(0, i).join(QLatin1Char('.'));
			wildcard += QLatin1String(".*");
			subPath = parts.mid(i).join(QLatin1Char('.'));
		}

		const auto watchers = m_watchers.value(wildcard);
		if (watchers.isEmpty()) {
			continue;
		}

		for (const WatchEntry &entry : watchers) {
			try {
				entry.watcher(value, subPath);
			} catch (const std::exception &e) {
				log::error(QStringLiteral("Store 订阅者处理 '%1'（通配 %2）时抛出异常: %3")
							   .arg(path, wildcard, QString::fromUtf8(e.what())));
			} catch (...) {
				log::error(QStringLiteral("Store 订阅者处理 '%1'（通配 %2）时抛出未知异常").arg(path, wildcard));
			}
		}
	}
}

} // namespace moo
