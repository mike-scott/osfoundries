+++
title = "Product"
description = "Open Source Foundries Products"
keywords = ["FAQ","How do I","questions","what if"]
+++

## Overview
Open Source Foundries products are Zephyr RTOS and Linux microPlatforms to enable you to rapidly develop secure, OTA updatable connected products. Whether your application is a remote sensor, a smart light or device, an appliance, or even a robot, drone or self-driving car the microPlatforms provide a proven, tested platform on which to securely build your product and applications. 

(icons/graphics of range of products)

microPlatforms are configurable minimum footprint implementations of software for building any connected device, whether based on a microcontroller or advanced multi-core SoCs. The microPlatforms are Open Source products so you have access to all the source code at no charge, and Open Source Foundries offer a lifetime subscription service (per product not per unit) to enable you to keep your product maintained with the latest security fixes, updates and new functionality over its lifetime. 

(security graphics)

As well as the microPlatform software itself, the Open Source Foundries product is delivered with an end to end open source reference implementation that shows you how to securely deliver and collect data and services to and from your own or third party server/cloud platforms. Using this software you can securely publish sensor data from devices to the fog or cloud, receive conmands or data back, and perform over the air updates to your devices and applications. 

(end to end diagram/photo)

## Linux microPlatform
The Linux microPlatform is a complete software implementation for an updatable, connected device. It comprises a recent Linux kernel.org stable kernel tested on a variety of SoCs, and a minimal set of services to run product applications and services in Docker Containers.  The microPlatform is deliberately intended to be a minimal core implementation using best practices to increase security through reducing attack surfaces, and to increase product quality and performance. A typical headless implementation with networking stack and supporting Docker Containers uses about (350MB) of storage. 

(Picture of Stack)

Firmware
To support an end to end secure platform, trusted firmware supporting secure boot and a Trusted Execution Environment (TEE) is required. A reference implementation using Arm Trusted Firmware, OP-TEE and UEFI is available for the HiKey Linux development platform. Documentation is provided to help you follow best practices in implementing a fully secure product for your own hardware choice.  

Kernel and Services
A recent kernel.org stable kernel version is supported and tested as part of the Linux microPlatforn. We subscribe to the "less is more" philosophy in delivering a minimum set of services needed to run Docker Containers. This minimizes the overall software footprint, increases security by limiting the software available for compromise, and helps improve quality and stability through comprehensive testing of the supplied functionality. Features such as packaging support are not included by default, as we expect your own application and services to be securely delivered and managed in Docker containers. (? language support eg Java, Go, Python etc.)

Application Deployment
The Open Source Foundries end to end reference implementation provides an example of using Containers for yoor own application. The Linux microPlatform is used for a simple gateway application to interface sensors and controllers using IoT protocols such as LWM2M and MQTT to cloud providers. Leshan and Hawkbit open source device management software is used to securely configure, update and manage the gateway application. 

(Block diagram of simple gateway)

## Zephyr microPlatform
The Zephyr microPlatform, based on the Zephyr real-time operating system, is targeted at microcontroller-based devices.

(to do)

## Lifetime Maintenance
Open Source Foundries products are continuously updated, integrated, tested and delivered to subscribers. In today's connected world, where devices are connected 24/7 to the internet, it is no longer feasible to build, test and deploy products without a secure way of updating them. While secure boot and encrypted data can be implemented, modern software is complex and near impossible to make completely tamper-proof. All products need to be able to be updated through their product lifetime with bug fixes and security updates. Traditionally this is achieved by maintaining products through support for long term supported infrastructure (for example an LTS operating system kernel). However, this only addesses the kernel itself and not the entire software stack from bootloader to application. Over a connected product lifetime (which can be many years) it is much easier, faster and less error-prone to perform updates on the latest software, than to have to engineer modern security patches into a particular build on devices that may be many years old. A continuously updatable product provides lower maintenance costs, protection against software vulnerabilities and other security threats, and also has the added benefit of allowing you to deliver new features to the end customer over the product lifetime. 

Open Source Foundries provides a subscription for 24/7 updates to the microPlatform products enabling you to maintain your customer products and selectively update them with the latest software, bug and security fixes. These can be deployed to the end product on a continuous basis, or as planned updates, perhaps when introducing new features or functionality. We do not provide the actual update service, since this is dependent on your product, geography, connectivity service and cloud delivery solution. Therefore, there are no per-update charges. However, our end to end reference implemnentation includes open source server/cloud device management and update software to enable continuous intgration and testing of the microPlatforms, that you can also use for your own product development or deployment. The microPlatforms support third party device management cloud vendors who use industry standard IoT protocols. We will be continuously testing with major industry device management providers - let us know if you would like to add a particular provider to our roadmap. 

By leveraging these updates into your own software development and product testing cycle you can offer your customers the latest software for your product including critical security fixes at any time during its life. Furthermore, we will never "lock you in" to our services. At any time you are able to stop your subscription and take over the ongoing software maintenance of the microPlatform yourself. 
---

> In case you haven't found what you are looking for, please feel free to contact us (link) and we will get back to you as soon as we can.
