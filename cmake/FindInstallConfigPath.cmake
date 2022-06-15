# XDG standards expects system-wide configuration files in the /etc/xdg/lxqt location.
# Unfortunately QSettings we are using internally can be overriden in the Qt compilation
# time to use different path for system-wide configs. (for example configure ... -sysconfdir /etc/settings ...)
# This path can be found calling Qt qmake:
#   qmake -query QT_INSTALL_CONFIGURATION
#

find_package(Qt6 COMPONENTS CoreTools REQUIRED)

macro(print_set_lxqt_etc_xdg_dir_info)
    message(STATUS "You can set it manually with -DLXQT_ETC_XDG_DIR=<value>")
    message(STATUS "")
endmacro()


if(NOT DEFINED LXQT_ETC_XDG_DIR)
    if (TARGET Qt6::qmake)
        get_target_property(_qt_qmake_executable Qt6::qmake IMPORTED_LOCATION)
    endif()

    if(NOT _qt_qmake_executable)
        message(FATAL_ERROR
            "LXQT_ETC_XDG_DIR: qmake executable not found (included before qt was configured?)")
    endif()

    set(qt_variable "QT_INSTALL_CONFIGURATION")
    execute_process(
        COMMAND ${_qt_qmake_executable} -query "${qt_variable}"
        RESULT_VARIABLE return_code
        OUTPUT_VARIABLE output
    )
    if(return_code EQUAL 0)
        string(STRIP "${output}" output)
        file(TO_CMAKE_PATH "${output}" output_path)
    else()
        message(STATUS "Got nothing from: ${_qt_qmake_executable} -query \"${qt_variable}\". LXQT_ETC_XDG_DIR will be set to '/etc/xdg'")
        set(output_path "/etc/xdg")
    endif()

    set(QT_QMAKE_EXECUTABLE ${_qt_qmake_executable}
        CACHE FILEPATH "Location of the Qt6 qmake executable")

    set(LXQT_ETC_XDG_DIR ${output_path}
        CACHE FILEPATH "Location of the LXQt XDG system-wide configuration files")

    message(STATUS "LXQT_ETC_XDG_DIR autodetected as '${LXQT_ETC_XDG_DIR}'")
    print_set_lxqt_etc_xdg_dir_info()
endif ()

