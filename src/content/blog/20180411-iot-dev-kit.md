+++
title = "Using AT&T's IoT Dev Kit"
date = "2018-04-11"
tags = ["lwm2m", "LTE", "AT&T", "ota", "update", "open source"]
categories = ["LwM2M", "FOTA"]
banner = "img/banners/lwm2m.png"
+++

In the Zephyr microPlatform update 0.13, we have released support for the
[AT&T IoT Starter Kit (LTE-M)](https://marketplace.att.com/products/att-iot-starter-kit-lte-m).

With the following instructions you can start using Zephyr and the IoT Starter Kit with LWM2M in a matter of minutes.
<!--more-->

## Hardware Requirements

* [AT&T IoT Starter Kit (LTE-M)](https://marketplace.att.com/products/att-iot-starter-kit-lte-m)

## AT&T device setup

To provision your device for use on AT&T's network you will need to follow the AT&T guide @ https://marketplace.att.com/products/att-iot-starter-kit-lte-m

Key items include:

* Update the firmware on the WCN14A2A modem:
https://s3-us-west-2.amazonaws.com/starterkit-assets/LTE-M.Firmware.Upgrade.Guide.pdf

* Register your AT&T IoT Starter Kit:
http://cloudconnectkits.org/

* Register your AT&T SIM:
https://marketplace.att.com/app/register-sims

* Download any documentation you require / want:
http://cloudconnectkits.org/product/att-cellular-iot-starter-kit#tabs-related_parts_and_documentation-middle


## Zephyr microPlatform Software Requirements

* As this support is part of a subscriber update, you'll need to setup a trial subscription account on [https://Foundries.io](https://foundries.io)
* [Install the Zephyr microplatform](https://foundries.io/docs/latest/tutorial/installation-zephyr.html)

__Enable Logging and network subsystem__

file: zephyr-fota-samples/dm-lwm2m/boards/frdm_k64f-local.conf

```
#This setting is not important, it is used to enable the network subsystem
CONFIG_NET_APP_MY_IPV4_ADDR="192.168.0.99"

# Optional configuration to show more debug output
#CONFIG_SYS_LOG_EXT_HOOK=n
#CONFIG_SYS_LOG_MODEM_LEVEL=4
```

__Build and flash the sample to the BLE Nano 2__

Use the following commands from the base directory of the ZMP:

```
./zmp build --board frdm_k64f --overlay-config "boards/wcn14a2a.conf" zephyr-fota-samples/dm-lwm2m
./zmp flash --board frdm_k64f zephyr-fota-samples/dm-lwm2m

```

__Find your device id__

In the future we will provide an update that uses your IMEI from your modem so your device on Leshan is easier to spot.

* __osf:imei:IMEI-NUMBER-ON-RADIO__

For now, you will need to connect to your K64F using a serial terminal, i.e. screen

Connect to your K64F device using screen and look for the Registration Done (EP='').  This will be the "Registration ID" on the Leshan client list @ http://leshan.eclipse.org/#/clients

```
screen /dev/tty.usbmodem1462 115200

[0731130] [lib/lwm2m_rd_client] [INF] do_registration_reply_cb: Registration Done (EP='A1ENFQxI3j')
```

```

__Confirm that Leshan UI displays your connected device__

Open the Leshan Demo Server instance in a web browser using the following URL: http://leshan.eclipse.org/#/clients

Find the BLE Nano 2 under the "Client Endpoint" list.  The endpoint is generated semi-randomly using unique data from the device to ensure that each endpoint name is unique.

![Leshan Demo Server client list](../../../../../img/blog/leshan-client-list.png)

**CAUTION: If you do not have good LTE signal, the device will not stay on-line for very long**
