find_package(Vulkan REQUIRED)

add_executable(hello-vulkan
	main.cpp)

target_link_libraries(hello-vulkan Vulkan::Vulkan glm glfw)
target_compile_definitions(hello-vulkan PUBLIC
	GLFW_INCLUDE_VULKAN 
	GLM_FORCE_RADIANS 
	GLM_FORCE_DEPTH_ZERO_TO_ONE)