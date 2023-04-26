# XDG standards expects system-wide configuration files in the /etc/xdg/lxqt location.
# Unfortunately QSettings we are using internally can be overriden in the Qt compilation
# time to use different path for system-wide configs. (for example configure ... -sysconfdir /etc/settings ...)
# This path can be found calling Qt qmake:
#   qtpaths --query QT_INSTALL_CONFIGURATION
#

find_package(Qt6 COMPONENTS CoreTools REQUIRED)

macro(print_set_lxqt_etc_xdg_dir_info)
    message(STATUS "You can set it manually with -DLXQT_ETC_XDG_DIR=<value>")
    message(STATUS "")
endmacro()

include(${PROJECT_SOURCE_DIR}/cmake/modules/LXQtQueryQt.cmake)

if(NOT DEFINED LXQT_ETC_XDG_DIR)
    set(qt_variable "QT_INSTALL_CONFIGURATION")
    lxqt_query_qt(output_path ${qt_variable} IGNORE_ERRORS)
    if (output_path STREQUAL "")
        set(output_path "/etc/xdg")
        set(LXQT_ETC_XDG_DIR ${output_path}
            CACHE FILEPATH "Location of the LXQt XDG system-wide configuration files")
        message(STATUS "Got nothing from: ${QUERY_EXECUTABLE} --query \"${qt_variable}\"")
        message(STATUS "Unable to autodetect LXQT_ETC_XDG_DIR. LXQT_ETC_XDG_DIR will be set to '/etc/xdg'")
    else()
        set(LXQT_ETC_XDG_DIR ${output_path}
            CACHE FILEPATH "Location of the LXQt XDG system-wide configuration files")
        message(STATUS "LXQT_ETC_XDG_DIR autodetected as '${LXQT_ETC_XDG_DIR}'")
    endif()
endif()

print_set_lxqt_etc_xdg_dir_info()
