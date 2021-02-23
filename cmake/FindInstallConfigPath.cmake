# XDG standards expects system-wide configuration files in the /etc/xdg/lxqt location.
# Unfortunately QSettings we are using internally can be overriden in the Qt compilation
# time to use different path for system-wide configs. (for example configure ... -sysconfdir /etc/settings ...)
# This path can be found calling Qt qmake:
#   qmake -query QT_INSTALL_CONFIGURATION
#

find_package(Qt6 COMPONENTS BuildInternals Core CoreTools REQUIRED)

message(STATUS "QT6_INSTALL_CONFIGURATION: ${QT6_INSTALL_CONFIGURATION}")
message(STATUS "QT_INSTALL_DIR: ${QT_INSTALL_DIR}")
message(STATUS "QT6_INSTALL_PLUGINS: ${QT6_INSTALL_PLUGINS}")
message(STATUS "QT_INSTALL_PLUGINS: ${QT_INSTALL_PLUGINS}")
message(STATUS "QT_SYS_CONF_DIR" "${QT_SYS_CONF_DIR}")
message(STATUS "INSTALL_SYSCONFDIR: ${INSTALL_SYSCONFDIR}")
message(STATUS "INSTALL_PLUGINSDIR: ${INSTALL_PLUGINSDIR}")

if(NOT DEFINED LXQT2_ETC_XDG_DIR)
    if (TARGET Qt6::qmake)
        get_target_property(_qt_qmake_executable Qt6::qmake IMPORTED_LOCATION)
    endif()

    if(NOT _qt_qmake_executable)
        message(FATAL_ERROR
            "LXQT2_ETC_XDG_DIR: qmake executable not found (included before qt was configured?)")
    endif()

    execute_process(COMMAND ${_qt_qmake_executable} -query QT_INSTALL_CONFIGURATION
                    OUTPUT_VARIABLE _lxqt_etc_xdg_dir
                    OUTPUT_STRIP_TRAILING_WHITESPACE)

    set(QT_QMAKE_EXECUTABLE ${_qt_qmake_executable}
        CACHE FILEPATH "Location of the Qt6 qmake executable")

    set(LXQT2_ETC_XDG_DIR ${_lxqt_etc_xdg_dir}
        CACHE FILEPATH "Location of the LXQt XDG system-wide configuration files")

    message(STATUS "LXQT2_ETC_XDG_DIR autodetected as '${LXQT2_ETC_XDG_DIR}'")
    message(STATUS "You can set it manually with -DLXQT2_ETC_XDG_DIR=<value>")
    message(STATUS "")
endif ()

