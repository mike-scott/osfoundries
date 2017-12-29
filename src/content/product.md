+++
title = "Product"
description = "Open Source Foundries Products"
keywords = ["FAQ","How do I","questions","what if"]
+++

## Overview
Open Source Foundries products are Zephyr RTOS and Linux microPlatforms to enable you to rapidly develop secure, OTA updatable connected products. Whether your application is a remote sensor, a smart light or device, an appliance, or even a robot, drone or self-driving car the microPlatforms provide a proven, tested platform on which to securely build your product and applications. 

  - icons of range of products

microPlatforms are configurable minimum footprint implementations of software for building any connected device, whether based on a microcontroller or advanced multi-core SoCs. The microPlatforms are Open Source products so you have access to all the source code at no charge, and Open Source Foundries offer a lifetime subscription service (per product not per unit) to enable you to keep your product maintained with the latest security fixes, updates and new functionality over its lifetime. 

  - security graphics

As well as the microPlatform software itself, the Open Source Foundries product is delivered with an end to end open source reference implementation that shows you how to securely deliver and collect data and services to and from your own or third party server/cloud platforms. Using this software you can securely publish sensor data from devices to the fog or cloud, receive conmands or data back, and perform over the air updates to your devices and applications. 

  - end to end diagram/photo

## Linux microPlatform
The Linux microPlatform is a complete software implementation for an updatable, connected device. It comprises a recent Linux kernel.org stable kernel tested on a variety of SoCs, and a minimal set of services to run product applications and services in Docker Containers.  The microPlatform is deliberately intended to be a minimal core implementation using best practices to increase security through reducing attack surfaces, and to increase product quality and performance. A typical headless implementation with networking stack and supporting Docker Containers uses about (350MB) of storage. 

(Picture of Stack)

Firmware
To support an end to end secure platform, trusted firmware supporting secure boot and a Trusted Execution Environment (TEE) is required. A reference implementation using Arm Trusted Firmware, OP-TEE and UEFI is available for the HiKey Linux development platform. Documentation is provided to help you follow best practices in implementing a fully secure product for your own hardware choice.  

Kernel and Services
A recent kernel.org stable kernel version is supported and tested as part of the Linux microPlatforn. We subscribe to the "less is more" philosophy in delivering a minimum set of services needed to run Docker Containers. This minimizes the overall software footprint, increases security by limiting the software available for compromise, and helps improve quality and stability through comprehensive testing of the supplied functionality. Features such as packaging support are not included by default, as we expect your own application and services to be securely delivered and managed in Docker containers. (? language support eg Java, Go, Python etc.)

Application Deployment
The Open Source Foundries end to end reference platform provides an example of using Containers for yoor own application. The Linux microPlatform is used for a simple gateway application to interface sensors and controllers using IoT protocols such as LWM2M and MQTT to cloud providers. Leshan and Hawkbit open source device management software is used to securely configure, update and manage the gateway application. 

(Block diagram of simple gateway)

## Zephyr microPlatform

The Zephyr microPlatform, based on the Zephyr real-time operating system, is targeted at microcontroller-based devices.

---

> In case you haven't found what you are looking for, please feel free to contact us and we will get back to you as soon as we can.
