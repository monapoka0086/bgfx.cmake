# bgfx.cmake - bgfx building in cmake
# Written in 2017 by Joshua Brookover <joshua.al.brookover@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

if( TARGET etc1 )
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

file( GLOB ETC1_SOURCES ${BIMG_DIR}/3rdparty/etc1/*.cpp ${BIMG_DIR}/3rdparty/etc1/*.h )

add_library( etc1 STATIC ${ETC1_SOURCES} )
target_include_directories( etc1 PUBLIC $<BUILD_INTERFACE:${BIMG_DIR}/3rdparty> )
set_target_properties( etc1 PROPERTIES FOLDER "bgfx/3rdparty" )
