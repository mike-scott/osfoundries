+++
title = "Product"
description = "Open Source Foundries Products"
keywords = ["FAQ","How do I","questions","what if"]
+++

## Overview
Open Source Foundries products are Zephyr RTOS and Linux microPlatforms to
enable you to rapidly develop secure, OTA updatable connected products.
Whether your application is a remote sensor, a smart light or device, an
appliance, or even a robot, drone or self-driving car the microPlatforms
provide a proven, tested platform on which to securely build your product
and applications.

microPlatforms are configurable minimum footprint implementations of software
for building any connected device, whether based on a microcontroller or
advanced multi-core SoCs. The microPlatforms are Open Source products so you
have access to all the source code at no charge, and Open Source Foundries
offer a lifetime subscription service (per product not per unit) to enable
you to keep your product maintained with the latest security fixes, updates
and new functionality over its lifetime.

## Linux microPlatform
The Linux microPlatform is a complete software implementation for an updatable,
connected device. It comprises a recent Linux kernel.org stable kernel tested
on a variety of SoCs, and a minimal set of services to run product applications
and services in Docker Containers. The microPlatform is deliberately intended
to be a minimal core implementation using best practices to increase security
through reducing attack surfaces, and to increase product quality and
performance. A typical headless product implementation with networking stack and
supporting Docker Containers will use less than 200MB of storage.

microPlatforms are configurable minimum footprint implementations of software
for building any connected device, whether based on a microcontroller or
advanced multi-core SoCs. The microPlatforms are Open Source products so you
have access to all the source code at no charge, and Open Source Foundries
offer a lifetime subscription service (per product not per unit) to enable
you to keep your product maintained with the latest security fixes, updates
and new functionality over its lifetime.

![Linux microPlatform Block diagram](../img/linux-blockdiagram.png)

![Linux microPlatform Gateway Diagram](../img/lmp-gateway.png)

## Zephyr microPlatform
The Zephyr Project is a scalable, cross-architecture RTOS for constrained
devices, built with internet connectivity and security from the outset. At
Open Source Foundries we base our RTOS microPlatform on Zephyr because we
believe that it is the future “Linux kernel of microcontrollers”. The OS has
an open governance model like the Linux kernel, that allows for companies and
individuals to add features and functionality and evolve the RTOS over time.
Unlike the Linux kernel, Zephyr is licensed under the permissive Apache 2.0
open source license, allowing you to easily integrate your own proprietary
technology.

The Open Source Foundries Zephyr microPlatform is a complete secure, OTA
updatable, product template for building a microcontroller based connected
product. It includes the following key features:

* MCUboot secure bootloader
* Image updater
* Zephyr kernel
* Networking and communications stacks
* Example sensor and actuator/control applications

![Zephyr microPlatform Block diagram](../img/zephyr-blockdiagram.png)

__MCUboot__

MCUboot is a secure, single thread bootloader that executes from flash memory
and provides a secure boot process using an immutable public key or key-hash
stored in the microcontroller. We provide documentation on how to replace the
sample developer key with your own key. The microPlatform can also be modified
to utilize any custom security hardware available.
Image Updater

The image updater enables A/B signed image loading and roll-back. This is used
to carry out secure OTA updates to your product.
Zephyr Kernel

The Zephyr kernel provides a small footprint, high performance, multi-threaded
execution environment for higher level stacks, libraries and applications. A
minimal Zephyr-based implementation can use less than 8KB of memory. More
complex applications including WiFi and Bluetooth can be implemented in less
than 64KB of ROM.

__Networking and Communications Stacks__

Zephyr supports a variety of communications stacks for networking, Bluetooth
including mesh, 802.15.4. Support for new low power and 5G standards including
LoRa, NB-IoT and LTE-M is underway. IoT network protocols including DTLS,
LwM2M and MQTT are supported, and more powerful devices can use the full TCP,
TLS and HTTPS stack. The Zephyr microPlatform is continuously tested with
multiple BLE and BLE Mesh device configurations, with both LwM2M and MQTT
protocols. The microPlatform networking interfaces can be configured to your
specific hardware requirements. Open Source Foundries will be adding
additional reference wireless support in the continuous updates.
Example Applications

Your product application is compiled and built using the Zephyr SDK, available
for Linux, Mac and Windows platforms. Open Source Foundries provides an out
of the box installation so you can focus on your application and not on
setting up tools. The reference implementation provides a sample application
for gathering device sensor data and controlling devices connected to the MCU.
Security

The Zephyr microPlatform is designed to enable simple development of secure
devices, with a secure boot architecture, signed update process and
encrypted data transfers using DTLS or TLS. By default the microPlatform
assumes you will install an immutable public key (or hash) into the MCU
during the MCU and/or product manufacturing process. A suitable source of
entropy for the True Random Number Generator (TRNG) function is also required.
You may also take advantage of any additional security functions that may be
available in your product hardware. Documentation is available to help you
ensure that your product takes advantage of the provided security
infrastructure.

The Zephyr Project is evolving rapidly with new functionality being added on
a regular basis. The microPlatform is a stable, integrated and tested
Zephyr-based product platform that is targeted as the foundation of a
connected device. Our end to end continuous integration and testing and
continuous update process means that you can focus on your application,
leaving Open Source Foundries to ensure that the microPlatform remains
stable and functional. With each update we provide full information on
changes and new functionality so that you are easily able to keep your
product software updated.

## End to end testing
As well as the microPlatform software itself, the Open Source Foundries
product is delivered with an end to end open source reference implementation
that shows you how to securely deliver and collect data and services to and
from your own or third party server/cloud platforms. Using this software you
can securely publish sensor data from devices to the fog or cloud, receive
commands or data back, and perform over the air updates to your devices and
applications.

![IoT System built on LWM2M](../img/endtoend.png)


## Lifetime Support

Open Source Foundries products are continuously updated, integrated, tested
and delivered to subscribers. In today’s connected world, where devices are
permanently connected to the internet, it is no longer feasible to build, test
and deploy products without a secure way of updating them. While secure boot
and encrypted data can be implemented, modern software is complex and near
impossible to make completely tamper-proof. All products need to be able to
be updated through their product lifetime with bug fixes and security updates.
Traditionally this is achieved by maintaining products through support for
long term supported infrastructure (for example an LTS operating system
kernel).

However, this only addresses the kernel itself and not the entire software
stack from bootloader to application. Over a connected product lifetime
(which can be many years) it is much easier, faster and less error-prone
to perform updates on the latest software, than to have to engineer modern
security patches into a particular build on devices that may be many years
old. A continuously updatable product provides lower maintenance costs,
protection against software vulnerabilities and other security threats, and
also has the added benefit of allowing you to deliver new features to the
end customer over the product lifetime.

Open Source Foundries offers a subscription for continuous updates to the
microPlatform products enabling you to maintain your customer products and
selectively update them with the latest software, bug and security fixes.
These can be deployed to the end product on a continuous basis, or as planned
updates, perhaps when introducing new features or functionality. We do not
provide the actual update service, since this is dependent on your product,
geography, connectivity service and cloud delivery solution. Therefore, there
are no per-update charges. However, our end to end reference implementation
includes open source server/cloud device management and update software to
enable continuous integration and testing of the microPlatforms, that you can
also use for your own product development or deployment. The microPlatforms
support third party device management cloud vendors who use industry standard
IoT protocols. We will be continuously testing with major industry device
management providers - let us know if you would like to add a particular
provider to our roadmap.

By leveraging these updates into your own software development and product
testing cycle you can offer your customers the latest software for your
product including critical security fixes at any time during its life.
Furthermore, we will never “lock you in” to our services. At any time you
are able to stop your subscription and take over the ongoing software
maintenance of the microPlatform yourself.

---
