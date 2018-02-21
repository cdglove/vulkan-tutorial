find_package(Vulkan REQUIRED)

add_executable(hello-triangle
	main.cpp)

target_link_libraries(hello-triangle Vulkan::Vulkan glm glfw)
target_compile_definitions(hello-triangle PUBLIC
	GLFW_INCLUDE_VULKAN 
	GLM_FORCE_RADIANS 
	GLM_FORCE_DEPTH_ZERO_TO_ONE)

target_add_glsl(
	TARGET hello-triangle 
	SOURCES shader.frag shader.vert 
	DESTINATION shaders)