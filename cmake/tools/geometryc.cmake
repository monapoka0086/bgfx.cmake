# bgfx.cmake - bgfx building in cmake
# Written in 2017 by Joshua Brookover <joshua.al.brookover@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

include( CMakeParseArguments )

include( ${CMAKE_CURRENT_LIST_DIR}/../3rdparty/meshoptimizer.cmake )

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


add_executable( geometryc ${BGFX_DIR}/tools/geometryc/geometryc.cpp )
target_compile_definitions( geometryc PRIVATE "-D_CRT_SECURE_NO_WARNINGS" )
set_target_properties( geometryc PROPERTIES FOLDER "bgfx/tools" )
target_link_libraries( geometryc bx bgfx-vertexlayout meshoptimizer )
if( BGFX_CUSTOM_TARGETS )
	add_dependencies( tools geometryc )
endif()

if (IOS)
	set_target_properties(geometryc PROPERTIES MACOSX_BUNDLE ON
											   MACOSX_BUNDLE_GUI_IDENTIFIER geometryc)
endif()
