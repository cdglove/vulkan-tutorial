find_package(Vulkan REQUIRED)
set(TARGET_NAME multisampling)

add_executable(
	${TARGET_NAME}
	main.cpp
	${SOURCES_SRC_CMN})

target_link_libraries(${TARGET_NAME} Vulkan::Vulkan glm glfw)
target_compile_definitions(${TARGET_NAME} PUBLIC
	GLFW_INCLUDE_VULKAN 
	GLM_FORCE_RADIANS 
	GLM_FORCE_DEPTH_ZERO_TO_ONE
	GLM_ENABLE_EXPERIMENTAL)

target_include_directories(${TARGET_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/contrib/stb)
target_include_directories(${TARGET_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/contrib/tinyobjloader)

configure_file(${PROJECT_SOURCE_DIR}/assets/textures/chalet.jpg textures/chalet.jpg COPYONLY)
configure_file(${PROJECT_SOURCE_DIR}/assets/models/chalet.obj models/chalet.obj COPYONLY)

target_add_glsl(
	TARGET ${TARGET_NAME}
	SOURCES shader.frag shader.vert 
	DESTINATION shaders)