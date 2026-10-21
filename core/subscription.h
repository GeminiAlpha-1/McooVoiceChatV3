// Copyright The Mumble Developers. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file at the root of the
// Mumble source tree or at <https://www.mumble.info/LICENSE>.

#pragma once

#include <functional>
#include <memory>
#include <utility>

namespace moo {

/// 订阅句柄：退订动作由句柄自己带着，最后一份句柄消失时自动退订。
///
/// 拷贝是**共享**的：多份句柄指向同一次订阅，退订是幂等的——
/// 任何一份先取消，其余副本随之失效。
/// 这样模块可以自己留一份（保证资源随模块回收），
/// 同时把另一份交给调用方（允许调用方提前取消），两边不会互相打架。
class Subscription {
public:
	Subscription() = default;

	explicit Subscription(std::function< void() > cancel) {
		if (cancel) {
			m_state           = std::make_shared< State >();
			m_state->m_cancel = std::move(cancel);
		}
	}

	Subscription(const Subscription &) = default;
	Subscription &operator=(const Subscription &) = default;
	Subscription(Subscription &&) noexcept        = default;
	Subscription &operator=(Subscription &&) noexcept = default;

	/// 退订。可重复调用，只有第一次生效。
	void cancel() {
		if (!m_state) {
			return;
		}
		std::function< void() > action = std::exchange(m_state->m_cancel, {});
		if (action) {
			action();
		}
	}

	/// 是否仍然有效。
	bool isActive() const { return m_state && static_cast< bool >(m_state->m_cancel); }

private:
	struct State {
		std::function< void() > m_cancel;

		/// 最后一份句柄消失时兜底退订。
		~State() {
			if (m_cancel) {
				m_cancel();
			}
		}
	};

	std::shared_ptr< State > m_state;
};

} // namespace moo
