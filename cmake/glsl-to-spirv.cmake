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
    set(SPIRV "${PROJECT_BINARY_DIR}/${GLSL_DESTINATION}/${FILE_NAME}.spv")
    add_custom_command(
      OUTPUT ${SPIRV}
      COMMAND ${CMAKE_COMMAND} -E make_directory "${PROJECT_BINARY_DIR}/${GLSL_DESTINATION}/"
      COMMAND ${GLSL_VALIDATOR} -V ${CMAKE_CURRENT_SOURCE_DIR}/${GLSL} -o ${SPIRV}
      DEPENDS ${GLSL})
    list(APPEND SPIRV_BINARY_FILES ${SPIRV})
  endforeach(GLSL)

  add_custom_target(
      Shaders 
      DEPENDS ${SPIRV_BINARY_FILES}
      )

  add_dependencies(${GLSL_TARGET} Shaders)

  add_custom_command(TARGET ${GLSL_TARGET} POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E make_directory "$<TARGET_FILE_DIR:${GLSL_TARGET}>/${GLSL_DESTINATION}/"
      COMMAND ${CMAKE_COMMAND} -E copy_directory
          "${PROJECT_BINARY_DIR}/${GLSL_DESTINATION}"
          "$<TARGET_FILE_DIR:${GLSL_TARGET}>/${GLSL_DESTINATION}"
          )
endfunction(target_add_glsl)