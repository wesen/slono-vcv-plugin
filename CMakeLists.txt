# CMake templates from Dale Emery's [DHE Modules](https://dhemery.github.io/DHE-Modules/)

cmake_minimum_required (VERSION 3.13)
#project (slono VERSION 1.0.0 LANGUAGES CXX)
enable_testing ()

if (APPLE)
    set (RACK_STAGING_DIR /Users/manuel/Documents/Rack)
elseif (UNIX)
    set (RACK_STAGING_DIR /home/manuel/.Rack)
endif ()
set (RACK_PLUGINS_DIR ${RACK_STAGING_DIR}/plugins-v1/slono)

add_subdirectory (external)
add_subdirectory (plugin)

install (DIRECTORY res
    DESTINATION ${RACK_PLUGINS_DIR}
    )
install (DIRECTORY presets
    DESTINATION ${RACK_PLUGINS_DIR}
    )
install (FILES LICENSE.txt plugin.json
    DESTINATION ${RACK_PLUGINS_DIR}
    )

set (CMAKE_CXX_STANDARD 14)

include_directories (plugin)

