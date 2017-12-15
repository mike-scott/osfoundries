+++
title = "microPlatform update 0.4"
date = "2017-12-13T13:50:46+02:00"
tags = ["linux", "zephyr", "update", "cve", "bugs"]
categories = ["updates", "microPlatform"]
banner = "img/banners/update.png"
+++

# Zephyr microPlatform

## Highlights

- Zephyr tree based on v1.10

## Components


### MCUBoot


#### Features
- Not addressed in this update

#### Bugs
- Not addressed in this update

### Zephyr


#### Features
- Not addressed in this update

#### Bugs

##### Bluetooth fixes: 
- Notable fixes include over ten patches to Bluetooth
Mesh, along with two fixes to the core BT controller
code.



##### CMake fixes: 
- The CMake build system received several fixes for
various issues.



##### IPv6 ND fix: 
- A fix to the core IPv6 networking code was merged which
fixes how random timers are initialized during neighbor
discovery, eliminating erroneous traffic on the network.



### Zephyr FOTA Samples


#### Features

##### hawkBit switches to new HTTP library: 
- The hawkBit demo has been updated to use the new HTTP
library. This eliminates various deprecation-related
warnings in the build.


#### Bugs

##### Fixes for local.conf files: 
- The build has been fixed for users who have a local.conf
in one of their application directories.


# Linux microPlatform

## Highlights

- No changes were made since 0.3

## Components


