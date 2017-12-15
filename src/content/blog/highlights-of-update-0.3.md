+++
title = "Update 0.3"
date = "2017-12-07T13:50:46+02:00"
tags = ["updates"]
categories = ["starting"]
banner = "img/banners/banner-2.jpg"
+++

## Introduction

This is the first Zephyr microPlatform update which uses the new CMake build system, which has replaced the use of Kbuild.
All users will need to update any out of tree application build systems.

### Zephyr
- Bug Fixes
 - Bluetooth fixes
  - Notable fixes include over ten patches to Bluetooth Mesh, along with two fixes to the core BT controller code.
 - CMake fixes
  - The CMake build system received several fixes for various issues.
 - IPv6 ND fix
  - A fix to the core IPv6 networking code was merged which fixes how random timers are initialized during neighbor discovery, eliminating erroneous traffic on the network.

hawkBit switches to new HTTP library
The hawkBit demo has been updated to use the new HTTP library. This eliminates various deprecation-related warnings in the build.
Bug Fixes
Fixes for local.conf files
The build has been fixed for users who have a local.conf in one of their application directories.

### linux
