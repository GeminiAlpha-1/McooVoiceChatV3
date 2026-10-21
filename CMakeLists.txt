cmake_minimum_required(VERSION 3.28...4.2)

project(McooVoiceChatV3
	VERSION 0.1
	DESCRIPTION "MOO 语音软件框架层"
	LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Module 里带 Q_OBJECT，moc 由 CMake 自动跑。
set(CMAKE_AUTOMOC ON)

option(MOO_BUILD_TESTS "构建单元测试" ON)
option(MOO_WARNINGS_AS_ERRORS "把编译警告当作错误" ON)

if (MSVC)
	# /utf-8 必须开：源码里的中文注释与中文字面量都按 UTF-8 处理，
	# 否则会被按系统代码页解释，跨机器构建就乱码。
	add_compile_options(/W4 /permissive- /utf-8 /Zc:__cplusplus)
	if (MOO_WARNINGS_AS_ERRORS)
		add_compile_options(/WX)
	endif()
else()
	add_compile_options(-Wall -Wextra)
	if (MOO_WARNINGS_AS_ERRORS)
		add_compile_options(-Werror)
	endif()
endif()

find_package(Qt6 REQUIRED COMPONENTS Core)

add_subdirectory(core)
