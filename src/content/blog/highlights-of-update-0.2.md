+++
title = "Update 0.2"
date = "2017-11-16T13:50:46+02:00"
tags = ["updates"]
categories = ["starting"]
banner = "img/banners/banner-2.jpg"
+++


This is the final release which uses the Linux kernel Kbuild build system. The next release will have a CMake-based build system. **All out of tree applications will need updates** to their build systems to move to CMake. Refer to the Zephyr Application Development Primer for details: http://docs.zephyrproject.org/application/application.html

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
