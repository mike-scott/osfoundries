+++
title = "Update 0.1"
date = "2017-11-16T13:50:46+02:00"
tags = ["updates"]
categories = ["starting"]
banner = "img/banners/banner-2.jpg"
+++


This release includes a Zephyr tree from the the 1.10 development cycle. This tree does not yet include the conversion of the build system to CMake. It includes an MCUBoot tree based on work done in the master branch following the v1.0.0 tag, which includes some work making it easier to port new boards to the bootloader than it was in that release. Finally, several sample applications are included, with numerous improvements from publicly released versions.

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
