# bgfx.cmake - bgfx building in cmake
# Written in 2017 by Joshua Brookover <joshua.al.brookover@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

include( CMakeParseArguments )

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

add_executable( texturec ${BIMG_DIR}/tools/texturec/texturec.cpp )
set_target_properties( texturec PROPERTIES FOLDER "bgfx/tools" )
target_link_libraries( texturec bimg )
if( BGFX_CUSTOM_TARGETS )
	add_dependencies( tools texturec )
endif()

if (ANDROID)
	target_link_libraries( texturec log )
elseif (IOS)
	set_target_properties(texturec PROPERTIES MACOSX_BUNDLE ON
											  MACOSX_BUNDLE_GUI_IDENTIFIER texturec)
endif()
