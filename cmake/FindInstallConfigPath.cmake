# XDG standards expects system-wide configuration files in the /etc/xdg/lxqt location.
# Unfortunately QSettings we are using internally can be overriden in the Qt compilation
# time to use different path for system-wide configs. (for example configure ... -sysconfdir /etc/settings ...)
# This path can be found calling Qt qmake:
#   qmake -query QT_INSTALL_CONFIGURATION
#

find_package(Qt6CoreTools REQUIRED)

if(NOT DEFINED LXQT_ETC_XDG_DIR)
    if (TARGET Qt6::qmake)
        get_target_property(_qt_qmake_executable Qt6::qmake IMPORTED_LOCATION)
    endif()

    if(NOT _qt_qmake_executable)
        message(FATAL_ERROR
            "LXQT_ETC_XDG_DIR: qmake executable not found (included before qt was configured?)")
    endif()

    execute_process(COMMAND ${_qt_qmake_executable} -query QT_INSTALL_CONFIGURATION
                    OUTPUT_VARIABLE _lxqt_etc_xdg_dir
                    OUTPUT_STRIP_TRAILING_WHITESPACE)

    set(QT_QMAKE_EXECUTABLE ${_qt_qmake_executable}
        CACHE FILEPATH "Location of the Qt6 qmake executable")

    set(LXQT_ETC_XDG_DIR ${_lxqt_etc_xdg_dir}
        CACHE FILEPATH "Location of the LXQt XDG system-wide configuration files")

    message(STATUS "LXQT_ETC_XDG_DIR autodetected as '${LXQT_ETC_XDG_DIR}'")
    message(STATUS "You can set it manually with -DLXQT_ETC_XDG_DIR=<value>")
    message(STATUS "")
endif ()

