// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#pragma once

#include <QString>

#include <exception>

namespace moo {

/// 统一日志出口。
///
/// 目前直接转接到 Qt 的消息处理器（qWarning / qCritical），
/// 这样独立构建与嵌入 Mumble 客户端时都能出日志；
/// 后续若要接 Mumble 自己的日志系统，只需要改这一个文件。
namespace log {

	/// 普通告警：不中断流程，但需要留痕。
	void warn(const QString &message);

	/// 错误：必须能被定位。异常指针非空时一并记录其内容。
	void error(const QString &message, const std::exception *exception = nullptr);

} // namespace log

} // namespace moo
