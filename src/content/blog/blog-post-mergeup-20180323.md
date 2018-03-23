+++
title = "zephyr mergeup log for March 23, 2018"
date = "2018-03-23"
tags = ["zephyr", "bluetooth", "iot"]
categories = ["mergeups"]
banner = "img/banners/mergeup.png"
draft = true
+++

Highlights
----------

Zephyr now has a virtual file system (VFS) switch, similar in spirit
to other operating systems. This also allows supporting multiple file
systems in a single Zephyr configuration.

Zephyr's logging subsystem now support a syslog-compliant network
backend. This logging protocol is standardized in RFC 5424 and RFC
5426.

The networking subsystem now has a net-app based websocket
library. Initial support is provided for the server role, with
optional TLS. Sample applications are provided in
samples/net/ws_echo_server and samples/net/ws_console.

Some ARM CMSIS headers were cleaned up and removed, which will break
applications using removed APIs.

The nRF5 SoC family support was globally renamed to nRF, to accomodate
incoming SoC support for Nordic targets that are not part of the nRF5
family. This may break applications using Kconfig or other names that
were affected.

Though not strictly a Zephyr feature, there is now an Elixir code
indexing server available for current and older Zephyr versions
available from Bootlin at:
https://elixir.bootlin.com/zephyr/latest/source
<!--more-->

Features
--------

A base64 library was added to Zephyr's core; it was imported from the
mbedTLS implementation. The mgmt subsystem and websockets support use
this new base64 library.

New architecture-related features include support for STM32F051X8,
STM32L073xZ, STM32F070XB, and STM32F412CG MCUs, as wel las stm32l0 and
stm32f446 SoCs.

The effort to support ARM v8M continues with additional fault handling
and logging for processor states present in those SoCs.

x86 and nRF SoC support for I2C now comes from device tree, with board
support for x86 on the galileo, curie, quark_x1000, and quark_d200
boards, and nRF support on bbc_microbit, nrf51_vbluno51, nrf52_vbluno52.

The ARC architecture now supports DTS, with nodes added for UARTs.

Support for configuring the direction of stack growth via Kconfig was
added.

The Bluetooth-specific LL randomness driver was ported to the Zephyr
entropy framework. The Bluetooth core now uses the entropy subsystem
instead of this random driver.

The sam_e70_explained board now enables Ethernet by default.

The nucleo_f412zg board now uses ethernet over USB as its default
network interface.

The native POSIX target now has an Ethernet driver. A sample is
provided in samples/net/eth_native_posix.

USB support was enabled on the Arduino Zero and Trinket M0 boards.

Device-tree based USB support was added for nrf52840_pca10056.

SPI2 support was enabled on the olimexino_stm32 board.

Support was added for the Adafruit Feather M0 Basic Proto,
nucleo-f446re, NUCLEO-L073RZ, nucleo_f070rb, STM32F0DISCOVERY,
Waveshare BLE400, 96Boards Argonkey, Olimex stm32-h407, and Dragino
boards.

USB, GPIO, and SPI device drivers were merged for Atmel SAM0.

An interrupt-driven UART driver was added for SAM E70.

Clock control, GPIO, interrupts, and pinmux drivers were merged for
stm32l0x.

A GPIO driver was merged for Semtech SX1509B I2C-based GPIO chips.

Numerous cleanups and improvements were merged to the I2C driver core
and individual drivers.

Cleanups and unifications were merged to the core scheduler APIs.

Improvements to the the BSD-like sockets API include MSG_DONTWAIT and
MSG_PEEK support in recvfrom, MSG_DONTWAIT in sendto, a freeaddrinfo
implementation, and empty service support in getaddrinfo.

Bug Fixes
---------

The Arm MPS2 SoC support was cleaned up.

x86 targets now unwind the stack on fatal errors.

POSIX target semaphore support received fixes.

Bluetooth Mesh fixes for cfg_cli were merged, addressing a null
pointer dereference and a race condition.

The SPI pinmux was fixed on Arduino Zero.

Fixes to the nRF USB driver were merged affecting isochronous
endpoints and CDC-ACM OUT endpoints.

Kernel memory partitions are now correctly placed in kernel memory
when building with userspace support.

A bug fix in the scheduler avoids undefined integer shifting behavior.

Networking fixes include net-app debug level checks, better handling
for malformed ICMPv6 echo requests, a compilation fix if the neighbor
cache is disabled, an IPv6 memory leak caused by echo requests,

Upstream Changes
================

Arches:

- cc69d373 arch: arm: Change method of __swap processing
- 28758fe9 arch: arm: STM32F051X8 support
- efbb7c61 arch/arm/soc/stm32f4: Add STM32F412CG MCU support
- deeb7465 arm: stm32l0: Add support for stm32l0 soc
- 8834a8d4 arm: stm32f446: Add support for stm32f446 SoC
- bd0ff309 arch: arm: cmsis: cleanup cmsis.h and update error-code macros
- 3b2f4b39 arch: arm: add missing floating-point fault logging
- ad18f84f arch: arm: Refactor CONFIG_CORTEX_M
- 51db7b14 arch: arm: mps2: Remove unused defines and structs
- fa0e8fd0 arch: arm: mps2: remove soc_memory_map.h
- 97331d1e arch: arm: mps2: Remove soc_irq.h
- d2e0d975 arch: arm: ARMv7-M/ARMv8-M Mainline dependency for programmable prios
- cfab6e08 arch: arm: define ARMv8-M Mainline K-option
- b75b0105 arch: arm: Stack Overflow Usage Fault log for ARMv8-M Mainline
- 10b40eca arch: arm: conditionally select FP extension in cortex-m MCUs
- c028f88b arch: arm: remove redundant asm inline headers
- 422bc240 soc: nrf5: Use i2c configure options generated from dts
- 6a1cb654 arch: arm: soc: stm32l0: fix indentation and comments in Kconfigs
- b6da79cb arch: arm: soc: stm32l0: add STM32L073xZ SOC
- a01e7903 arch: arm: SecureFault Handling for Cortex-M33
- 5475de10 arch: arm: define the ARM_SECURE_FIRMWARE option
- c9b02085 arm: mps2_an385: Move dts.fixup to board dir
- 9ae3fdc2 arch: arm: soc: stm32l0: add I2C support
- 0ecd77e4 arch: arc: quark_se_c1000_ss: Fix DCCM_SIZE
- 00c05202 arch: arm: soc: stm32l0: add I2C support
- 494bf568 arch: arm: soc: stm32f0: add STM32F070XB SOC
- e00564d1 x86: fix logic for thread wrappers
- 2f5659d4 arch: x86: Unwind the stack on fatal errors
- a967915e arch: add Kconfig for stack growth direction
- 9d367eeb xtensa, kernel/sched: Move next switch_handle selection to the scheduler
- f49150ca arch: arm: nrf: Rename nrf5 SoC Family to nrf
- b2016da5 arch: arm: nrf: Rename common header to apply to all nRFx ICs
- 66569695 arch: arm: nordic_nrf: Restore copyright years
- 65607ee1 arch: arm: SecureFault_IRQn for non-CMSIS-compliant MCUs
- 342da7ac posix: semaphore: fix bugs and simplify code
- 9ddd8d1e arch/x86: Enable i2c through DTS for quark_se SS
- 5fc1f5ff arch/x86: Enable i2c through DTS for quark_se
- 2e972bc8 arch/x86: Enable i2c through DTS for quark_d2000
- 60ec8be3 arch: em{7,9,11}d: Add dts support
- 311e6b9e arch: arc: Use DTS for all ARC SoCs
- 8a824356 arch: arc: em{7,9,11}d: Add initial DTS UART support

Bluetooth:

- 5c162dfe Bluetooth: hci_usb: Write large packets to USB in multiple chunks
- 3b857e18 Bluetooth: hci_usb: Read the whole USB EPOUT buffer at once
- c2d7c857 Bluetooth: btp: Add missing Clear Replay Protection List Cache cmd
- fd212491 Bluetooth: btp: Add Enable advertising with Node Identity cmd
- fb3387a4 Bluetooth: Remove rand driver and use entropy instead
- 7fd4184d Bluetooth: Mesh: cfg_cli: Fix trying to write a NULL pointer
- 0cee4ed7 Bluetooth: Mesh: cfg_cli: Fix possible race condition
- 7d4514a8 Bluetooth: Add option to force using identity address for advertising
- ac133268 Bluetooth: Remove 'own_addr' from advertising parameters
- bf8050b0 Bluetooth: Mesh: Introduce debug option to use identity address

Boards:

- 0ee0752b boards: nucleo_f412zg: Enable eth over USB as default net i/f
- b7de2af1 boards: olimex stm32-e407: Fix comment
- 490e4274 boards: document and enable USB on the Arduino Zero and Trinket M0.
- 7973860c boards: Add support for the Adafruit Feather M0 Basic Proto.
- 32ef59a4 boards: arm: add support for STM32F0DISCOVERY
- a1e5dc1b boards/arm/olimexino_stm32: Enable SPI2 port
- ff7fd44a boards: sam4s_xplained: Changed the sample to use USB on debug port
- 2bf1fe20 boards: arm: Add support for 96Boards Argonkey Board
- cc1a0f72 boards: arm: Add Dragino LSN50 LoRA node
- 74db6bfa boards: arm: Add nucleo-f446re board
- 679f401f boards: adafruit_feather_m0_basic_proto: Disable legacy SPI API.
- 0f3286f9 boards: arm: enable CLOCK_STM32_HSE_BYPASS in Nucleo F0/F3 defconfigs
- 34a38816 boards: adafruit_feather_m0_basic_proto: Add USB device support.
- a6b55edb adafruit_feather_m0_basic_proto: Enable usb controller in board dts
- f3077da3 boards: arduino_zero: Fix SPI pinmux configuration.
- 71bda84b boards: arm: nrf5: Enable i2c dts nodes for boards
- 92c7bd03 boards: arm: add NUCLEO-L073RZ board
- 570be1b6 boards: mps2_an385: cleanup pinmux comments
- ec72a71e boards: arm: nucleo_l073rz: add I2C support
- d6e3f22f boards: arm: improve Nucleo boards documentation formatting
- f7bf4701 boards: olimex stm32-h407: Add initial support
- 9d2915b7 boards: Remove USB VID/PID from tinytile
- d5de4773 boards: arm: nrf: Make USB default for nrf52840_pca10056 board
- 11c5eb75 boards: arm: nucleo_l073rz: add SPI support
- 242c583c boards: nucleo_l432kc: provide flash support
- 3289fbe1 boards: arm: argonkey: Add flashing section to documentation
- ccab4e28 boards: nucleo_f070rb: add new board
- fb0cee8e boards: Add support for Waveshare BLE400 board.
- 69957a3d boards: Add "ram" and "flash" properties for a number of boards
- 1c5e6b2d qemu_x86: enable CONFIG_DEBUG_INFO
- 6320dce4 boards: sensortag: Update links to reference manual
- 9643fd2b boards: sam_e70_explained: Enable ethernet by default
- e35a4a25 boards/galileo: Switch to DTS for generating i2c settings

Build:

- d8b6f54f cmake: 'ninja flash' support for sam4s_xplained
- b2dfb327 kconfig: Don't source the non-existing zephyr/net/Kconfig
- 1d75f251 kconfig: Removed source "[...]mgmt/mcumgr/mgmt/port/zephyr/Kconfig"
- 9afb0cfa kconfig: Remove UTF-8 character from author's name
- 8500134c kconfig: Decode Kconfig sources as UTF-8 instead of as LC_CTYPE
- 799b4563 Revert "kconfig: Decode Kconfig sources as UTF-8 instead of [...]"
- 64f85887 cmake: Minor refactor
- 777e0a1b cmake: Support UTF-8 characters in Kconfig values
- 98456b30 cmake: fix set_ifndef() usage patterns

Continuous Integration:

- 25f6ab62 Revert "sanitycheck: Default to using Ninja"

Cryptography:

- 7558ce8c mbedtls: Add CONFIG_MBEDTLS_SSL_MAX_CONTENT_LEN
- e8257891 mbedtls: Replace COAP-specific max len setting with generic

Device Tree:

- bbb4b402 dts: arm: provider support for the stm32l0
- 0b9ad29a dts: bindings: i2c: Add bindings for i2c_nrf5
- 516a1791 dts: arm: nrf5: Add i2c nodes
- d9637621 dts: bindings: Add yaml file for nRF52840 USBD support to DT
- 037dddbe dts: arm: nrf52840_pca10056: Use DT to configure USB
- 7789f9ac dts/i2c: Fixing copyright headers
- 1ad56e3c dts: Add yaml descriptor for the DW i2c driver
- f98382a9 dts: Add yaml descriptor for the QMSI i2c driver
- a913ba03 dts: Add yaml descriptor for the QMSI SS i2c driver
- 12a1823e dts/arc: Add the i2c node in Quark SE SS C1000
- e8e14f84 dts/x86: Add the i2c node in quark_x1000
- 5b229b29 dts/x86: Add the i2c node in intel curie
- f55a2953 dts/x86: Add the i2c node in quark_d2000

Documentation:

- 80f7d41f doc: Fix K_ALERT_DEFINE in a code example
- 1be0c956 doc: boards: Fixed doc. output with hello_world sample
- a706a687 doc: add test coverage and proposal policy
- d5841d72 doc: fix doxy syntax for hiding internal symbols
- 71ddd825 doc: Add 'apt-get install python3-wheel' to linux installation docs
- f8d45125 doc: Kconfig: Decode Kconfig sources as UTF-8 instead of as LC_CTYPE
- e2d73fb1 doc: application: Add Eclipse debugging section
- 585fd1fa doc: kernel: capitalize Fifo/Lifo
- 11828bf6 doc: do not show undocumented members
- 639f8ed3 doc: http: add HTTP APIs to net group
- 43bc3046 Revert "doc: Kconfig: Decode Kconfig sources as UTF-8 instead [...]"
- 34d02e5e doc: fix backslashes in doc
- 029c3235 doc: Supplement list of implemented socket operations
- abc47a07 doc: Add Elixir cross-referencer to resources list
- be52e3c4 doc: Fix SAM0 SPI controller device names
- a5a29e4e doc: sphinx: Add Pygment lexer for DTS

Drivers:

- f2651d0c usb: sam0: add a USB device driver.
- c83f0782 gpio: sam0: add pull up/pull down support.
- a8a36a23 spi: sam0: use Device Tree for configuration.
- 12b5ef0e drivers: pinmux: stm32f4: Added configuration macro for I2C2 on PB9
- e99a79a9 drivers: clock_control: Provide support for stm32l0x
- ef1d32b8 drivers: gpio: Provide GPIO driver for stm32l0x
- 8e401e50 driver: interrupt_controller: Add support for stm32l0x
- baae89f2 driver: pinmux: Add pinmux driver for stm32l0x
- b9c65e18 drivers: GPIO Added GPIO for SAM family.
- aa7c91d0 driver: usart: Added support for interrupt driver USART on SAM E70.
- 40b7be51 drivers: i2c: Add DTS support to ARM SBCon I2C controller
- dc37f985 crc: make crc8_ccitt() match the other CRC functions.
- 3b78d937 usb: ateml: samd21: enable usb controller in board dts not soc
- 8d7da518 drivers: usb: device: code cleanup
- dd9719bf gpio: Add a driver for SX1509B
- 0186b073 usb: provide different USB product strings in the USB samples
- fa57ebd5 usb: Rename unicode into UTF16LE
- 813b41be drivers: entropy: Port the LL rand driver to entropy
- 49ed4fb2 clock_control: nrf5: Add USBD power event support for USB enumeration
- 380a2501 drivers: usbd_nrf5: Add nRF52840 USB Device Controller Driver
- bb9d5167 spi: sam0: fix CS and back-to-back transfers.
- 65db8e1e usb: cdc_acm: Fix typo
- 756c50aa usb: cdc_acm: Fix write when USB writes only chunk
- 4304b4c3 usb: cdc_acm: yield in the waiting loop
- 10923173 Revert "usb: stm32: Introduce transfer method"
- 9d1957fa usb_dc: Add usb_dc_ep_mps function
- 16921b06 usb: Add transfer management API
- ddb1b8f6 usb: usbnet: Add USBNET_MTU definition
- 5beb1838 usb: dc_dw: Fix FIFO available space
- e7fa746b usb: dc_dw: Do not clear RX NAK at init for transfer endpoints
- b4d305d7 usb: call status_callback on interface set
- c97d9c6c usb: netusb: consider media connected on interface selection event
- ccf0b46a usb: usbnet: ecm: Use transfer API
- 9a195e36 drivers: usb: nrf5: Add usb_dc_ep_mps function
- cfdaa1dc drivers: usb: nrf5: Fix cdc_acm OUT endpoint read size issue
- 120ddbc0 drivers: usb: nrf5: Fix ISO IN/OUT SOF handling
- 48a5fbca drivers: flash: stm32f0: remove CONFIG_FLASH_PAGE_SIZE
- 0f66426f drivers: eth: Add ethernet driver for native posix arch
- 8b8178b0 drivers: eth: gmac: Do not verify config for unit tests
- 8aa9a379 drivers: flash: nrf: Rename nrf5 to nrf
- 474a56b8 entropy: nrf5x remove unnecessary header
- c0c4dfc6 subsys: usb: usb_descriptor: fix style and function declaration
- 84cffc7f drivers: uart: stm32: make comments and options less specific
- 08418a21 drivers: uart: stm32: improve STM32L0 support
- 4d6d04d3 hid: change the API table to const.
- d95fa652 drivers/i2c: Cleanup Kconfig
- d506da28 drivers/i2c: Indent sources the same way everywhere
- 6d247b5c drivers/i2c: Rename generic configure option in DW drivers
- 860d40f9 drivers/i2c: Disable some QMSI SS option when HAS_DTS_I2C is enabled
- ae180401 drivers/i2c: Removing useless configuration attribute in DW driver
- 8f891ba7 drivers/i2c: Use standard bitrate settings for DW driver
- 9b77741d drivers/i2c: Use standard bitrate settings for QMSI driver
- 7af98f5e drivers/i2c: Use standard bitrate settings for QMSI SS driver
- 74d18355 drivers/i2c: Make QMSI SS driver IRQs set via CONFIG_ options

External:

- 3c789e6a hal: stm32l0x: Add HAL for the STM32L0x series
- bb3e5d71 ext/hal/stm32l0xx: Remove stm32l0xx_ll_usb from CMakeLists
- 37a5d267 ext: hal: cmsis: Update ARM CMSIS headers to version 5.3.0
- 849c8a4e ext: hal: stm32l0xx: spi: remove offending cast
- a8b801f1 ext: nffs: update for enabling statistic

Firmware Update:

- 42953062 mgmt: Switch to new base64 library

Kernel:

- a1ae8453 kernel: Name of static functions should not begin with an underscore
- 813e9633 init: verify boot_delay
- 83752c1c kernel: introduce initial stack randomization
- c7ceef67 kernel_event_logger: Ignore events before subsystem init
- 85bc0a3f kernel: Cleanup, unify _add_thread_to_ready_q() and _ready_thread()
- 345553b1 kernel/queue: Clean up scheduler API usage
- 81242985 kernel/sched: Clean up docs for _pend_thread(), limit scope
- ee9bebf7 kernel: smp: group SMP options in Kconfig file
- 8470b4d3 kernel: kconfig: reorg kernel Kconfig a bit
- 3a6d72ec kernel: mem_domain: k_mem_partition is now placed in kernel memory.
- 166f5194 kernel: api: fix doxygen group ending
- 954d5503 kernel: api: mark internal functions as such
- c39e2a2d kernel: Fix left shift into sign bit

Libraries:

- bb64ec29 lib: move ring_buffer Kconfig to lib/, cleanup lib/Kconfig
- fb50e81d lib: Add base64 library
- 20cd4b55 lib: base64: Add statement of changes

Miscellaneous:

- 624897c6 release: Post-release patch level update
- 9f73d5e2 syslog: Add networking backend
- e5f1b51f debug: fix RTT console Kconfig

Networking:

- 8109bdf8 net: ipv6: Drop RA with MTU out of valid range
- b0c8cd80 net: sockets: Refactoring zsock_recvfrom
- d70c7383 net: websocket: Initial support for server websocket
- ead9cd40 net: websocket: Add console support
- c8879293 net: app: Enable syslog to network in init
- 7f8315a9 net: app: Fix debug level check
- c288bf7a net: icmpv6: Drop malformed ICMPv6 echo request
- 4cfca3ea net: ipv6: Fix compile error if neighbor cache is disabled
- c49d176c ieee802154: Make AR flag check generic and not tight to L2
- 175dd960 net: samples: Reduce net pkt RAM usage
- 158adc68 net: sockets: Support MSG_DONTWAIT flag in zsock_recvfrom
- b047f816 net: Create helper to convert MAC strings to array of bytes
- 317eae06 net: ethernet: Avoid overlapping memcpy for tx packets
- b3a5797d net: ipv6: fix memory leak caused by echo request
- 7c9c8251 net: sockets: Support MSG_PEEK flag in zsock_recvfrom
- ebb78459 net: pkt: net_pkt_get_reserve_data() was aliased incorrectly
- feec8bfa net: websocket: Leave space for null in strncpy
- 57e7ea87 net: sockets: Support MSG_DONTWAIT flag in zsock_sendto
- c8732d93 net: sockets: Add freeaddrinfo()
- 5f42a264 net: sockets: Allow empty service in getaddrinfo()
- 85a2459e net: Support network packet checksum calc offloading
- 6170ae5e net: websocket: Use system provided base64 function

Samples:

- a7e01f4d samples: net: Remove references to ZoAP
- ca6ebbdf samples: subsys: mgmt: mcumgr: Fix FS part of smp_svr example
- 1e6ed033 samples: net: websocket echo-server application
- 2f4fa71b samples: net: websocket: Add console sample application
- 2abba358 samples: net: syslog: Remote syslog service example
- 0fea45aa samples/tests: net: websocket: Fix yaml files
- e4212306 samples: net: eth_native_posix: Sample for native networking
- eaaab777 samples: usb: Make each sample have its own USB product string

Scripts:

- edbaeea2 scripts: nrfjprog.py: Add --softreset switch
- 66d6b581 scripts: extract_dts_includes: Fix path handling in Windows
- 76778582 scripts: extract_dts_inculdes: Fix issue if no zephyr,flash prop
- d485d6c5 uncrustify: add space before name of typedef
- 46239ba5 kconfiglib: Update to fd21c5cb320b9

Storage:

- 97929515 subsys: fs: Kconfig: Add log level support for fs subsystem
- 25302b19 subsys: fs: Add Virtual File system Switch (VFS) support
- 3e83a527 subsys: fs: Kconfig changes to enable multiple file systems
- d68b6a90 subsys: fs: Fix fs_file_t and fs_dir_t usage

Testing:

- 0e1a03b8 tests: crypto: mbedtls: enabled test for esp32
- e2a1682c tests: kernel: Add stack usage scenario tests
- f7c19034 tests: gpio: add a configuration for the Arduino Zero.
- b31ccd12 tests: spi_loopback: Fix Arduino Zero SPI device name.
- 9edc7ce4 tests: semaphore: test APIs
- a06cc42d tests: kernel: timers: Added a test to check periodicity
- eb30e80b tests: subsys: fs: Adapt fat_fs_api test as per VFS changes
- 3228e70b tests: subsys: fs: Adapt nffs_fs_api test as per VFS changes
- d3a6d933 tests: subsys: fs: Add test for multiple file systems
- 02347f9c tests: kernel: work_q: Add testcases
- 924e8aad tests: arm_runtime_nmi: Make test build on v8m
- 3108d054 tests: drivers: build_all: Add SX1509 GPIO test
- 4a90d975 tests: samples: Add nrf52840_pca10056 board to USB test cases
- 2114da01 tests: samples: Exclude nrf52840_pca10056 from wpanusb sample
- 4d4c7bf3 tests: net: websocket: Add tests for websocket
- 8b08f851 tests: net: websocket: Bump min ram to 46k
- f303337f tests: net: websocket: exclude qemu_xtensa
- 7f28edca tests/kernel/common: Random32 test update for entropy subsystem
- 24da695a tests: net: websocket: Fix buiding on qemu_xtensa
- cbd1c184 tests: mbox: mbox_api: Added required kconfigs to test obj tracing
- e20abd55 tests: mbox: mbox_api: Added new test cases.
- 11f7d174 tests: mbox: mbox_api: Disable execution on RAM constrained devices.
- 6b7435b8 tests: bluetooth: shell: Set min_flash to 145K
- bdfa0217 tests: kernel: Test for essential thread set/clear
- a47f14ac tests: Kconfig: Added a new kconfig.
- 84fed562 tests: kernel: pipe: Added new test cases for pipe.
- c7553acd tests: kernel: pipe_api: Run test with userspace enabled.
- fcf942af tests: msgq_api: Improve scenario testing
- 44eb8362 tests: net: websocket: Fix null pointer dereference
- f112b3ee tests: kernel: Add fifo usage scenario tests
- a2e13415 tests: kernel: Add fifo timeout scenario tests
- 04d2abb1 tests: kernel: alert: Add testcases
- 4aa49053 tests: posix: fix semaphore.h test
- aad9ab4b tests: Added test for UTF-8 characters in Kconfig values
- e1f0a3e1 tests: kernel: Add test to verify k_thread_start()
- 22eeb70a tests: net: Network packet checksum offloading tests
- ca1bb5ea test: lib: base64: Add a base64 test
- d55387e5 tests: crypto: rand32: move rand32 test out of kernel
- 093b8b9a tests: kernel: semaphore: Added tests for semaphore.
