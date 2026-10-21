find_package(Qt6 REQUIRED COMPONENTS Test)

# 一个测试文件一个可执行文件：QtTest 的 main 宏每个可执行文件只能有一个。
set(MOO_TEST_CASES
	store
	event_contracts
	event_bus
	module
	module_manager
)

foreach(case IN LISTS MOO_TEST_CASES)
	add_executable(moo_test_${case} test_${case}.cpp)
	target_link_libraries(moo_test_${case} PRIVATE moo_core Qt6::Test)
	add_test(NAME moo_test_${case} COMMAND moo_test_${case})
endforeach()
