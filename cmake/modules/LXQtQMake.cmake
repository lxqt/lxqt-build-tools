find_package(Qt6Core REQUIRED QUIET)

if (TARGET Qt6::qmake)
    get_target_property(_qmake_executable_default Qt6::qmake LOCATION)
endif()

set(QMAKE_EXECUTABLE ${_qmake_executable}
    CACHE FILEPATH "Location of the Qt6 qmake executable")

function(query_qmake result_variable qt_variable)
    set(options )
    set(oneValueArgs )
    set(multiValueArgs )

    cmake_parse_arguments(ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(NOT QMAKE_EXECUTABLE)
            message(FATAL_ERROR "No qmake Qt6 binary found. Can't check ${qt_variable} as required")
    endif()
    execute_process(
        COMMAND ${QMAKE_EXECUTABLE} -query "${qt_variable}"
        RESULT_VARIABLE return_code
        OUTPUT_VARIABLE output
    )
    if(return_code EQUAL 0)
        string(STRIP "${output}" output)
        file(TO_CMAKE_PATH "${output}" output_path)
        set(${result_variable} "${output_path}" PARENT_SCOPE)
    else()
        message(WARNING "Failed call: ${QMAKE_EXECUTABLE} -query \"${qt_variable}\"")
        message(FATAL_ERROR "QMake call failed: ${return_code}")
    endif()
endfunction()

