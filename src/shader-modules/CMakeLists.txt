find_package(Vulkan REQUIRED)

add_executable(shader-modules
	main.cpp)

target_link_libraries(shader-modules glfw Vulkan::Vulkan glm)
target_compile_definitions(shader-modules PUBLIC
	GLFW_INCLUDE_VULKAN 
	GLM_FORCE_RADIANS 
	GLM_FORCE_DEPTH_ZERO_TO_ONE)

target_add_glsl(TARGET shader-modules SOURCES shader.frag shader.vert DESTINATION shaders)