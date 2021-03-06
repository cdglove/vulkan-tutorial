function(target_add_glsl)
  set(options)
  set(oneValueArgs DESTINATION TARGET)
  set(multiValueArgs SOURCES)
  cmake_parse_arguments(GLSL "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

  # TODO: Get this from find vulkan?
  if (${CMAKE_HOST_SYSTEM_PROCESSOR} STREQUAL "AMD64")
    set(GLSL_VALIDATOR "$ENV{VULKAN_SDK}/Bin/glslangValidator.exe")
  else()
    set(GLSL_VALIDATOR "$ENV{VULKAN_SDK}/Bin32/glslangValidator.exe")
  endif()

  foreach(GLSL ${GLSL_SOURCES})
    get_filename_component(FILE_NAME ${GLSL} NAME)
    set(SPIRV "${GLSL_DESTINATION}/${FILE_NAME}.spv")
    add_custom_command(
      OUTPUT ${SPIRV}
      COMMAND ${CMAKE_COMMAND} -E make_directory "${GLSL_DESTINATION}/"
      COMMAND ${GLSL_VALIDATOR} -V "${CMAKE_CURRENT_SOURCE_DIR}/${GLSL}" -o "${SPIRV}"
      DEPENDS ${GLSL})
    list(APPEND SPIRV_BINARY_FILES "${SPIRV}")
  endforeach(GLSL)

  add_custom_target(
      ${GLSL_TARGET}-shaders 
      DEPENDS ${SPIRV_BINARY_FILES})

  add_dependencies(${GLSL_TARGET} ${GLSL_TARGET}-shaders)
  
endfunction(target_add_glsl)