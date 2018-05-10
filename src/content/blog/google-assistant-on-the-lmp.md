+++
author = ""
banner = ""
categories = []
date = "2018-05-09T19:48:23+00:00"
draft = true
tags = []
title = "Google Assistant on the LmP"

+++
In this blog, we'll describe how we create a container to run Google's Assistant on a simple Raspberry PI with a speaker and microphone.

<!-- more -->

## Hardware needed

1. Raspberry PI 3b (others should work, but for this demo we'll use the 3b)
   1. All the peripherals (5V micro-usb power, 8GB microSD card)
2. External speaker and Microphone
   1. $85 - [JABRA 510 USB/Bluetooth speaker phone](https://www.amazon.com/Jabra-Wireless-Bluetooth-Softphone-Packaging/dp/B00AQUO5RI) (speaker & Mic)
   2. $12 - [USHonk USB Speaker](https://www.amazon.com/USHONK-Speaker-Computer-Multimedia-Notebook/dp/B075M7FHM1) (speaker only)
   3. Headphones (speaker only)
   4. $5 - [Kinobo USB mic](https://www.amazon.com/Kinobo-Microphone-Desktop-Recognition-Software/dp/B00IR8R7WQ) (Mic only)

## Load the latest Linux microPlatform

Get all the latest software by using the latest microPlatform release. Sign up for a free trial to the subscription @ [https://foundries.io](https://foundries.io "https://foundries.io") and download the latest artifacts @ [https://foundries.io/mp/lmp/latest/artifacts/](https://foundries.io/mp/lmp/latest/artifacts/ "https://foundries.io/mp/lmp/latest/artifacts/").

Download a LmP pre-built binary for your Raspberry PI 3b, write it to a microSD card (using [Resin's Etcher.io project](https://etcher.io/)) or decompress and write it to the flash device using the dd command (i.e. sudo dd if=lmp-gateway-image-raspberrypi3-64.img of=/dev/sdH bs=4M).

Power on your device (5v microUSB power, Ethernet Cable to a Internet connected port, microSD card with the LmP running)

### 1. Connect to your raspberry PI using SSH

![](/uploads/2018/05/10/connect.png)

### 2. Find your microphone and speaker addresses

In order to route the audio to the right device we will need to find the hardware addresses (and possibly adjust the volume a bit).

1. Plug your device(s) into your Raspberry PI 3b (we will be using the Jabra Device)
2. Load and run a container that contains the ALSA subsystem (not this also happens to be the container we'll use to run the Google Assistant, but for now we are going to use it only to find the HW device IDs)
   1. Find the microphone device (Note: **Card 2** and **Device 0**)

          $ docker run -it --privileged opensourcefoundries/ok-google arecord -l
          setup authorized credentials file
          setup alsa configuration
          + exec arecord -l
          **** List of CAPTURE Hardware Devices ****
          card 2: USB [Jabra SPEAK 510 USB], device 0: USB Audio [USB Audio]
            Subdevices: 1/1
            Subdevice #0: subdevice #0
   2. Find the speaker device

          $ docker run -it --privileged opensourcefoundries/ok-google aplay -l
          setup authorized credentials file
          setup alsa configuration
          + exec aplay -l
          **** List of PLAYBACK Hardware Devices ****
          card 0: vc4hdmi [vc4-hdmi], device 0: MAI PCM vc4-hdmi-hifi-0 []
            Subdevices: 1/1
            Subdevice #0: subdevice #0
          card 1: ALSA [bcm2835 ALSA], device 0: bcm2835 ALSA [bcm2835 ALSA]
            Subdevices: 7/7
            Subdevice #0: subdevice #0
            Subdevice #1: subdevice #1
            Subdevice #2: subdevice #2
            Subdevice #3: subdevice #3
            Subdevice #4: subdevice #4
            Subdevice #5: subdevice #5
            Subdevice #6: subdevice #6
          card 1: ALSA [bcm2835 ALSA], device 1: bcm2835 ALSA [bcm2835 IEC958/HDMI]
            Subdevices: 1/1
            Subdevice #0: subdevice #0
          card 2: USB [Jabra SPEAK 510 USB], device 0: USB Audio [USB Audio]
            Subdevices: 1/1
            Subdevice #0: subdevice #0

Now we know that the MIC is HW:1,0 and the Speaker is HW:1,0 we will use this information for further adjustments.

1. Test the speaker volume

       $ docker run -it --privileged -e MIC_ADDR="hw:2,0" -e SPEAKER_ADDR="hw:2,0" opensourcefoundries/ok-google
       