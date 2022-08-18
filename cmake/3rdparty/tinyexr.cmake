if( TARGET tinyexr )
	return()
endif()

if (MSVC)
    add_compile_options("/MT")
    foreach(flag_var
        CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
        CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO)
      if(${flag_var} MATCHES "/MD")
        string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
      endif()
    endforeach()
endif()

file( GLOB_RECURSE TINYEXR_SOURCES ${BIMG_DIR}/3rdparty/tinyexr/*.c ${BIMG_DIR}/3rdparty/tinyexr/*.h )

add_library( tinyexr STATIC ${TINYEXR_SOURCES} )
target_include_directories( tinyexr PUBLIC $<BUILD_INTERFACE:${BIMG_DIR}/3rdparty> $<BUILD_INTERFACE:${BIMG_DIR}/3rdparty/tinyexr/deps/miniz> )
set_target_properties( tinyexr PROPERTIES FOLDER "bgfx/3rdparty" )
