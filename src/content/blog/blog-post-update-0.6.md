+++
title = "microPlatform update 0.6"
date = "2018-01-10T13:50:46+02:00"
tags = ["linux", "zephyr", "update", "cve", "bugs"]
categories = ["updates", "microPlatform"]
banner = "img/banners/update.png"
+++

# Zephyr microPlatform

## Highlights

- Bluetooth behaviors impacting MAC addresses are changed following Linux microPlatform update

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

##### LWM2M packet fix: 
- The LWM2M stack includes a fix which prevents a packet
which may need to be retransmitted from being freed
until after this retransmission has completed, if necessary.



### Zephyr FOTA Samples


#### Features

##### CONFIG_NET_L2_BT_ZEP1656 disabled: 
- This obscure option was used to preserve compatibility
contrary to the Bluetooth specification with
implementation characteristics in the Linux kernel. Now
that the upstream Linux microPlatform was updated to
v4.14, which has fixes for these characteristics, the
option can be disabled.


##### dm-hawkbit-mqtt cleanups and optimizations: 
- Various confusing implementation details in this
application have been fixed and otherwise cleaned
up. The resulting application now requires less memory.


#### Bugs

##### Packet pool workaround for MQTT: 
- The dm-hawkbit-mqttt sample now uses an extra packet
pool when the underlying link layer is Bluetooth. This
keeps the network stack working in the face of IPv6
packet header compression.


# Linux microPlatform

## Highlights

- OSF Unified Linux Kernel updated to the 4.14 series (4.14.7)

## Components


### Meta OSF Layer


#### Features

##### Layer Update: 
- OSF Unified Linux Kernel updated to the 4.14 series (4.14.7).


#### Bugs
- Not addressed in this update
