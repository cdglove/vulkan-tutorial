find_package(Vulkan REQUIRED)

add_executable(shader-modules
	main.cpp)

target_link_libraries(shader-modules Vulkan::Vulkan glm glfw)
target_compile_definitions(shader-modules PUBLIC
	GLFW_INCLUDE_VULKAN 
	GLM_FORCE_RADIANS 
	GLM_FORCE_DEPTH_ZERO_TO_ONE)