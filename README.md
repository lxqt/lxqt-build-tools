# lxqt-build-tools

## Introduction

This repository is providing several tools needed to build LXQt itself as well
as other components maintained by the LXQt project to ease dependency management.

## Installation

### Compiling sources

To build only CMake and Qt6Core are needed, optionally Git to pull VCS checkouts.
Runtime dependencies do not exist.

Code configuration is handled by CMake. CMake variable `CMAKE_INSTALL_PREFIX`
has to be set to `/usr` on most operating systems.

To build run `make`, to install `make install` which accepts variable `DESTDIR`
as usual. (Strictly speaking `make` isn't even needed right now. On the other
hand it doesn't hurt so packagers may just include it in case it'll be needed
one day.)

## Packagers

This package is arch-independent now.  You can simply package it as
`BuildArch: noarch` (rpm) or `arch: all` (deb).

## Current Minimum Versions

| Package                       | Version|
|-------------------------------|--------|
| LIBFM_QT_MINIMUM_VERSION      | 2.4.0  |
| LIBFMQT_MINIMUM_VERSION       | 2.4.0  |
| LXQTBT_MINIMUM_VERSION        | 2.4.0  |
| LXQT_MINIMUM_VERSION          | 2.4.0  |
| QTERMWIDGET_MINIMUM_VERSION   | 2.4.0  |
| QTXDG_MINIMUM_VERSION         | 4.4.0  |
| LIBMENUCACHE_MINIMUM_VERSION  | 1.1.0  |
| QT_MINIMUM_VERSION            | 6.10.0 |
| LAYERSHELL_QT_MINIMUM_VERSION | 6.6.0  |
| KF6_MINIMUM_VERSION           | 6.0.0  |
| KF6SCREEN_MINIMUM_VERSION     | 6.6.0  |
