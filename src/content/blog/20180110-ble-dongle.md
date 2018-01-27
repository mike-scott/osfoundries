+++
title = "Opensource Bluetooth Low Energy (BLE) USB dongle"
date = "2018-01-08"
tags = ["ble", "radio", "open source", "bugs"]
categories = ["Bluetooth", "Radio"]
banner = "img/banners/ble-dongle.png"
+++


If you've ever had to ship a product you know how frustrating a critical bug can be when your only driver is proprietary.  Many times the problem may be in your code and not the vendor's code, but it is often a difficult journey to find the root cause.  Vendors have many customers and finding the right technical contact takes time, and without a compelling business case you may ultimately find that your use of the device is not _standard_ and you end up at the back of the line, even sometimes forced to find a different component.  Well with Zephyr maybe we are beginning to take a step forward, as we now have an entirely open source BLE solution from the host to the client, and there are vendors that are talking about possibly providing an almost _ready-for-certification_ Bluetooth low energy radio stack based on Zephyr.
<!--more-->

## Hardware Requirements

Though we are currently focusing development on the Redbear Labs Nano v2 (nRF52), any nRF51/nRF52 board can be compatible with the setup, as long it provides a UART-USB converter that supports flow control.

* nRF51-PCA10028
* nRF52-PCA10040
* nRF52840-PCA10056
* Redbear Labs Nano v1 (nRF51)
* Redbear Labs Nano v2 (nRF52)

## Sourcecode

To get the radio to work you need to configure a Zephyr sample for your NRF5 device, and configure a linux host.  Due to flow control being disabled by default on the DAPLink USB adapter, you will also need to load modified DAPLink firmware.

### DAPLink USB firmware

To use with the stock DAPLink USB 1.5 adapter a firmware update is required, as the stock firmware has several issues with the USB CDC UART interface.

To update to the latest DAPLink firmware just follow the guide available at https://github.com/redbear/nRF5x/tree/master/USB-IF#daplink-usb-interface-daplink-v15 and enable flow control.  (NOTE: we provide a prebuilt version that we used during our internal tests below).

### Zephyr HCI UART sample changes required

The source code used for the bluetooth dongle is simply re-purposing the HCI-UART sample within the Zephyr sample tree and adding a few configuration items.

For the NRF5 device: $ZEPHYR_BASE/samples/bluetooth/hci_uart/nrf5.conf
```
 CONFIG_BT_CTLR_RX_BUFFERS=18
 CONFIG_BT_CTLR_TX_BUFFERS=19
 CONFIG_BT_CTLR_TX_BUFFER_SIZE=251
 CONFIG_BT_CTLR_DATA_LENGTH_MAX=251
 CONFIG_BT_HCI_CMD_COUNT=20
 CONFIG_BT_RX_BUF_COUNT=20
 CONFIG_BT_RX_BUF_LEN=264
```

You can also increase the number of connections above the default of 16 parallel bluetooth connections.  To increase, simply change CONFIG_BT_MAX_CONN in $ZEPHYR_BASE/samples/bluetooth/hci_uart/nrf5.conf.  We've had some success testing as many as 24 devices concurrently, but you'll want to make sure your performance is acceptable. Additional RX/TX buffers and larger data length should also used for better performance, if not restricted by RAM.

### Linux Host changes required

To use the BLE dongle in a linux computer you simply need to configure the BT attach service to use the dongle.

```
# Create bluetooth attach configuration file
cat << EOF > /etc/bluetooth/btattach.conf
HCITTY=/dev/ttyACM0
HCISPEED=1000000
HCIPROTO=h4
EOF

# restart btattach service
systemctl restart btattach.service
```

And that's it.


## Unsupported / pre-release binaries and instructions

https://github.com/OpenSourceFoundries/zephyr-ble-dongle/releases
