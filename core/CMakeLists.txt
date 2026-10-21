# 框架层。模块之间不互相引用，只依赖这里。
add_library(moo_core STATIC
	log.cpp
	log.h
	subscription.h
	store.cpp
	store.h
	event_contracts.cpp
	event_contracts.h
	event_bus.cpp
	event_bus.h
	module.cpp
	module.h
	module_manager.cpp
	module_manager.h
)

# 头文件用 `core/xxx.h` 的形式引用，所以暴露的是仓库根目录。
target_include_directories(moo_core PUBLIC ${PROJECT_SOURCE_DIR})

target_link_libraries(moo_core PUBLIC Qt6::Core)
