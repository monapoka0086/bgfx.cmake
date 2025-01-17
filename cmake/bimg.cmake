# bgfx.cmake - bgfx building in cmake
# Written in 2017 by Joshua Brookover <joshua.al.brookover@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# Third party libs
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/astc-codec.cmake )
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/astc.cmake )
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/edtaa3.cmake )
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/etc1.cmake )
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/etc2.cmake )
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/iqa.cmake )
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/libsquish.cmake )
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/nvtt.cmake )
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/pvrtc.cmake )
include( ${CMAKE_CURRENT_LIST_DIR}/3rdparty/tinyexr.cmake )

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

# Ensure the directory exists
if( NOT IS_DIRECTORY ${BIMG_DIR} )
	message( SEND_ERROR "Could not load bimg, directory does not exist. ${BIMG_DIR}" )
	return()
endif()

# Grab the bimg source files
file( GLOB BIMG_SOURCES ${BIMG_DIR}/src/*.cpp )

# Create the bimg target
add_library( bimg STATIC ${BIMG_SOURCES} )

# Add include directory of bimg
target_include_directories( bimg
	PUBLIC
		$<BUILD_INTERFACE:${BIMG_DIR}/include>
		$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# bimg dependencies
target_link_libraries( bimg PUBLIC bx PRIVATE astc-codec astc edtaa3 etc1 etc2 iqa squish nvtt pvrtc tinyexr )

# Put in a "bgfx" folder in Visual Studio
set_target_properties( bimg PROPERTIES FOLDER "bgfx" )
