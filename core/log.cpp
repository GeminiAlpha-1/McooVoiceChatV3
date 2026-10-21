// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#include "core/log.h"

#include <QLoggingCategory>
#include <QString>

#include <exception>

namespace moo {
namespace log {

	Q_LOGGING_CATEGORY(mooLog, "moo")

	void warn(const QString &message) { qCWarning(mooLog).noquote() << message; }

	void error(const QString &message, const std::exception *exception) {
		if (exception) {
			qCCritical(mooLog).noquote() << QStringLiteral("%1 | %2").arg(message,
																		  QString::fromUtf8(exception->what()));
		} else {
			qCCritical(mooLog).noquote() << message;
		}
	}

} // namespace log
} // namespace moo
