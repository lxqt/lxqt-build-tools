#.rst:
# FindXdgScreensaver
# ------------
#
# Try to find the xdg-screensaver executable
#
# This will define the following variables:
#
# ``XdgScreensaver_FOUND``
#     True if (the requested version of) XdgScreensaver is available
#
# ``XdgScreensaver_VERSION``
#     The version of XdgScreensaver
#
# ``XdgScreensaver_EXECUTABLE``
#     The xdg-screensaver executable
#
# If ``XdgScreensaver_FOUND`` is TRUE, it will also define the following imported
# target:
#
# ``XdgScreensaver::XdgScreensaver``
#     The xdg-screensaver executable
#
#
#=============================================================================
# Copyright (c) 2020, Luís Pereira <luis.artur.pereira@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#=============================================================================

include(FindPackageHandleStandardArgs)

set(_xdgscreensaver_REQUIRED_VARS)

set(_xdgscreensaver_QUIET)
if (XdgScreensaver_FIND_QUIETLY)
    set(_xdgscreensaver_QUIET QUIET)
endif()

set(_xdgscreensaver_REQUIRED)
if (XdgScreensaver_FIND_REQUIRED)
        set(_xdgscreensaver_REQUIRED REQUIRED)
endif()

find_program(XdgScreensaver_EXECUTABLE NAMES xdg-screensaver)

if (XdgScreensaver_EXECUTABLE)
    execute_process(COMMAND ${XdgScreensaver_EXECUTABLE} --version
        OUTPUT_VARIABLE _xdgscreensaver_version
        ERROR_QUIET
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
endif()

string(REGEX REPLACE "xdg-screensaver ([0-9]\\.[0-9]\\.[0-9]+).*"
    "\\1" XdgScreensaver_VERSION_STRING "${_xdgscreensaver_version}")

if (XdgScreensaver_FIND_REQUIRED)
    list(APPEND _xdgscreensaver_REQUIRED_VARS ${XdgScreensaver_EXECUTABLE})
endif()

find_package_handle_standard_args(XdgScreensaver
    REQUIRED_VARS _xdgscreensaver_REQUIRED_VARS
    VERSION_VAR XdgScreensaver_VERSION_STRING
)

if (XdgScreensaver_FOUND AND NOT TARGET XdgScreensaver::XdgScreensaver)
    add_executable(XdgScreensaver::XdgScreensaver IMPORTED)
    set_target_properties(XdgScreensaver::XdgScreensaver PROPERTIES
        IMPORTED_LOCATION "${XdgScreensaver_EXECUTABLE}"
    )
endif()

mark_as_advanced(XdgScreensaver_EXECUTABLE)
