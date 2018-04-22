find_package(Vulkan REQUIRED)

add_executable(model-loading
	main.cpp
	stb_image.cpp
	tinyobjloader.cpp)

target_link_libraries(model-loading Vulkan::Vulkan glm glfw)
target_compile_definitions(model-loading PUBLIC
	GLFW_INCLUDE_VULKAN 
	GLM_FORCE_RADIANS 
	GLM_FORCE_DEPTH_ZERO_TO_ONE
	GLM_ENABLE_EXPERIMENTAL)

target_include_directories(model-loading PRIVATE ${PROJECT_SOURCE_DIR}/contrib/stb)
target_include_directories(model-loading PRIVATE ${PROJECT_SOURCE_DIR}/contrib/tinyobjloader)

configure_file(${PROJECT_SOURCE_DIR}/assets/textures/chalet.jpg textures/chalet.jpg COPYONLY)
configure_file(${PROJECT_SOURCE_DIR}/assets/models/chalet.obj models/chalet.obj COPYONLY)

target_add_glsl(
	TARGET model-loading
	SOURCES shader.frag shader.vert 
	DESTINATION shaders)