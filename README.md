# lxqt-build-tools

## Introduction

This repository is providing several tools needed to build LXQt itself as well as other components maintained by the LXQt project.   

These tools used to be spread over the repositories of various other components and were summarized to ease dependency management. So far many components, in particular [liblxqt](https://github.com/lxde/liblxqt), were representing a build dependency without being needed themselves but only because their repository was providing a subset of the tools which are now summarized here. So the use of this repository will reduce superfluous and bloated dependencies.   

## Installation

### Compiling sources

To build only CMake and Qt5Core are needed, optionally Git to pull VCS checkouts. Runtime dependencies do not exist.   

Code configuration is handled by CMake. CMake variable `CMAKE_INSTALL_PREFIX` has to be set to `/usr` on most operating systems.   

To build run `make`, to install `make install` which accepts variable `DESTDIR` as usual. (Strictly speaking `make` isn't even needed right now. On the other hand it doesn't hurt so packagers may just include it in case it'll be needed one day.)

### Binary packages

The repository was introduced in September 2016 and binary packages are rare so far. On Arch Linux an [AUR](https://aur.archlinux.org/) package [lxqt-build-tools-git](https://aur.archlinux.org/packages/lxqt-build-tools-git/) can be used to build current checkouts of branch `master`.

### Distribution packagers

Please mention that the binary packages are arch-dependend right now. CMake adds a architecture check here:
```diff
--- amd64/usr/share/cmake/lxqt-build-tools/lxqt-build-tools-config-version.cmake
+++ i386/usr/share/cmake/lxqt-build-tools/lxqt-build-tools-config-version.cmake
@@ -19,13 +19,13 @@
 endif()
 
 # if the installed or the using project don't have CMAKE_SIZEOF_VOID_P set, ignore it:
-if("${CMAKE_SIZEOF_VOID_P}" STREQUAL "" OR "8" STREQUAL "")
+if("${CMAKE_SIZEOF_VOID_P}" STREQUAL "" OR "4" STREQUAL "")
    return()
 endif()
 
 # check that the installed version has the same 32/64bit-ness as the one which is currently searching:
-if(NOT CMAKE_SIZEOF_VOID_P STREQUAL "8")
-   math(EXPR installedBits "8 * 8")
+if(NOT CMAKE_SIZEOF_VOID_P STREQUAL "4")
+   math(EXPR installedBits "4 * 8")
    set(PACKAGE_VERSION "${PACKAGE_VERSION} (${installedBits}bit)")
    set(PACKAGE_VERSION_UNSUITABLE TRUE)
 endif()```ruby
```
