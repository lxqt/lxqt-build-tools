# This bit is taken from KDE ECMQueryQt module.
include(CheckLanguage)
check_language(CXX)
if (CMAKE_CXX_COMPILER)
    # Enable the CXX language to let CMake look for config files in library dirs.
    # See: https://gitlab.kitware.com/cmake/cmake/-/issues/23266
    enable_language(CXX)
endif()

# QUIET to accommodate the TRY option
find_package(Qt6 COMPONENTS CoreTools QUIET CONFIG)
if (TARGET Qt6::qtpaths)
    get_target_property(_qtpaths_executable Qt6::qtpaths LOCATION)

    set(QUERY_EXECUTABLE ${_qtpaths_executable}
        CACHE FILEPATH "Location of the Qt6 Query Executable")
endif()

function(lxqt_query_qt result_variable qt_variable)
    set(options IGNORE_ERRORS)
    set(oneValueArgs)
    set(multiValueArgs)

    cmake_parse_arguments(ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(NOT QUERY_EXECUTABLE)
        if (ARGS_IGNORE_ERRORS)
            set(${result_variable} "" PARENT_SCOPE)
            message(STATUS "No Qt6 Query Executable binary found. Can't check ${qt_variable} as required")
            return()
        else()
            message(FATAL_ERROR "No Qt6 Query Executable binary found. Can't check ${qt_variable} as required")
        endif()
    endif()
    execute_process(
        COMMAND ${QUERY_EXECUTABLE} --query "${qt_variable}"
        RESULT_VARIABLE return_code
        OUTPUT_VARIABLE output
    )
    if(return_code EQUAL 0)
        string(STRIP "${output}" output)
        file(TO_CMAKE_PATH "${output}" output_path)
        set(${result_variable} "${output_path}" PARENT_SCOPE)
    else()
        if (ARGS_IGNORE_ERRORS)
            set(${result_variable} "" PARENT_SCOPE)
            return()
        else()
            message(WARNING "Failed call: ${QUERY_EXECUTABLE} --query \"${qt_variable}\"")
            message(FATAL_ERROR "Qt6 Query Executable call failed: ${return_code}")
        endif()
    endif()
endfunction()

