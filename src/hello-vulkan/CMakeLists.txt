find_package(Vulkan REQUIRED)

set(TARGET_NAME hello-vulkan)
add_executable(${TARGET_NAME}
	main.cpp)

target_link_libraries(${TARGET_NAME} Vulkan::Vulkan glm glfw)
target_compile_definitions(${TARGET_NAME} PUBLIC
	GLFW_INCLUDE_VULKAN 
	GLM_FORCE_RADIANS 
	GLM_FORCE_DEPTH_ZERO_TO_ONE)