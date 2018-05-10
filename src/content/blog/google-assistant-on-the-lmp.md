+++
author = "Alan Bennett"
banner = "/uploads/2018/05/10/Google-Launches-the-Google-Assistant-SDK-for-3rd-Party-Companies.png"
categories = ["lmp"]
date = "2018-05-09T19:48:23+00:00"
draft = true
tags = ["Google", "Assistant", "Alsa"]
title = "Google Assistant on the LmP"

+++
In this blog, we'll describe how we create a container to run Google's Assistant on a simple Raspberry PI with a speaker and microphone.  Once you gather all the information necessary, this sample creates a simple, portable and easy to reproduce Google Assistant appliance out of your Raspberry PI.

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

    ssh osf@raspberrypi3-64.local

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
   2. Find the speaker device Jabra: **Card 2:** and **Device: 0** again

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

Now we know that the MIC is **2,0** and the Speaker is **2,0** we will be able to pass this information into the container for further adjustments.

1. Test the speaker volume
   1. Note: we pass in MIC__ADDR  and a SPEAKER__ADDR environment variables
   2. Note: we also call the 'speaker-test' utility and run the wav test.  You should hear "Front Left"

          $ docker run -it --privileged -e MIC_ADDR="hw:2,0" -e SPEAKER_ADDR="hw:2,0" opensourcefoundries/ok-google speaker-test -t wav
   3. Press CTRL-C to exit
2. Adjust the speaker volume, you can also adjust the MIC gain if you want using the alsamixer application

       $ docker run -it --privileged -e MIC_ADDR="hw:2,0" -e SPEAKER_ADDR="hw:2,0" opensourcefoundries/ok-google alsamixer

   ![](/uploads/2018/05/10/card.png)

   ![](/uploads/2018/05/10/sp-vol.png)

   ![](/uploads/2018/05/10/mic-vol.png)

After you adjust the volume, you can retest using speaker-test command from step 1 above.

### 3. Now to Authorize your device with the Google Cloud services

Note: Much of this blog was excerpted from Google's SDK documentation at [https://developers.google.com/assistant/sdk/guides/library/python/](https://developers.google.com/assistant/sdk/guides/library/python/ "https://developers.google.com/assistant/sdk/guides/library/python/")

#### Configure an Actions Console project

A Google Cloud Platform project, managed by the Actions Console, gives your device access to the Google Assistant API. The project tracks quota usage and gives you valuable metrics for the requests made from your device.

To enable access to the Google Assistant API, do the following:

1. [Open the Actions Console](https://console.actions.google.com/).
2. Click on Add/import project.
3. To create a new project, type a name in the Project name box and click CREATE PROJECT.

   _If you already have an existing Google Cloud Platform project, you can select that project and import it instead._
4. Click the **Device registration** box.
5. Enable the Google Assistant API on the project you selected (see the [Terms of Service](https://developers.google.com/assistant/sdk/terms-of-service)). You need to do this in the Cloud Platform Console.

   [ENABLE THE API](https://console.developers.google.com/apis/api/embeddedassistant.googleapis.com/overview)

   Click **Enable**.

#### Set activity controls for your account

In order to use the Google Assistant, you must share certain activity data with Google. The Google Assistant needs this data to function properly; this is not specific to the SDK.

Open the [Activity Controls page](https://myaccount.google.com/activitycontrols) for the Google account that you want to use with the Assistant. You can use any Google account, it does not need to be your developer account.

**Ensure the following toggle switches are enabled (blue)**:

* Web & App Activity
  * In addition, be sure to select the **Include Chrome browsing history and activity from websites and apps that use Google services** checkbox.
* Device Information
* Voice & Audio Activity

#### Register the Device Model

Use the registration UI in the Actions Console to register a device model.

1. Open the [Actions Console](https://console.actions.google.com/).
2. Select the project you created previously.
3. Select the **Device registration** tab (under **ADVANCED OPTIONS**) from the left navbar.
4. Click the **REGISTER MODEL** button.

#### Create model

1. Fill out all of the fields for your device.

   See the device model JSON [reference](https://developers.google.com/assistant/sdk/reference/device-registration/model-and-instance-schemas.html#device_model_json) for more information on these fields.
2. When you are finished, click **REGISTER MODEL**

#### Download credentials file

The `credentials.json` file must be located on the device. Later, you will run an authorization tool and reference this file in order to authorize the Google Assistant SDK sample to make Google Assistant queries. Do not rename this file.

Download this file and transfer it to the device.

    scp ~/Downloads/credentials.json osf@raspberrypi3-64.local:/home/osf/

### 4. Run the SDK and Sample code

In the Google samples you would now install software onto your target device, however the container you have been using to query the audio hardware is configured and ready to run the sample with no further modification.

#### Authorize your device

In order to connect your device to the Google services you will first need to generate the appropriate credentials.  We'll do this in a more interactive version using the bash shell and mapping in our credentials.json file from above.

    docker run -it --privileged -v ${PWD}/credentials.json:/credentials.json opensourcefoundries/ok-google bash
    google-oauthlib-tool --scope https://www.googleapis.com/auth/assistant-sdk-prototype \
              --scope https://www.googleapis.com/auth/gcm \
              --save --headless --client-secrets /credentials.json

Running google-oauthlib-tool will return a HTTPS URL that you will need to copy and paste into your browser to complete the authorization steps.

Copy the authorization code back into your terminal window to complete the authorization dance and get your credentials.

Note three values from your credentials file

    cat /root/.config/google-oauthlib-tool/credentials.json 
    
    {
      "client_secret": "kF4ZOjX",
      "scopes": [
        "https://www.googleapis.com/auth/assistant-sdk-prototype",
        "https://www.googleapis.com/auth/gcm"
      ],
      "token_uri": "https://accounts.google.com/o/oauth2/token",
      "client_id": "7520-5883.apps.googleusercontent.com",
      "refresh_token": "1/Ux2UDvinAjHYb6jbA"
    }

Now we can exit the container and re-launch it to run the ok-google sample and pass in all of the variables we have discovered.

    docker run -it --privileged \
       -e MIC_ADDR="hw:2,0" \
       -e SPEAKER_ADDR="hw:2,0" \
       -e PROJECT_ID=voice-kit-01 \
       -e MODEL_ID=voice-kit-01-number2-flc5yj \
       -e CLIENT_SECRET=kF4ZLu-X \
       -e CLIENT_ID=7508-5d3.apps.googleusercontent.com \
       -e REFRESH_TOKEN="1/Ux0k2DAjHYb6jbA" \
       opensourcefoundries/ok-google
    setup authorized credentials file
    setup alsa configuration
    + exec bash -c 'googlesamples-assistant-hotword --project_id ${PROJECT_ID}  --device_model_id ${MODEL_ID}'
    device_model_id: voice-kit-01-number2-flc5yj
    device_id: FB5D19145D253C8575B061402DF93723
    
    https://embeddedassistant.googleapis.com/v1alpha2/projects/voice-kit-01/devices/FB5D19145D253C8575B061402DF93723 404
    Registering....
    Device registered.
    ON_MUTED_CHANGED:
      {'is_muted': False}
    ON_START_FINISHED
    
    ON_CONVERSATION_TURN_STARTED
    ON_END_OF_UTTERANCE
    ON_RECOGNIZING_SPEECH_FINISHED:
      {'text': 'what time is it'}
    ON_RESPONDING_STARTED:
      {'is_error_response': False}
    ON_RESPONDING_FINISHED
    ON_CONVERSATION_TURN_FINISHED:
      {'with_follow_on_turn': False}

## Extra Credit: Portainer

One you know the necessary variables, you can use our Portainer templates to launch the container.

\[How to run Portainer on the Linux microPlatform Blog\]({{< relref "blog/20180508-portainer-container-management-on-linux-microplatform-.md" >}})

#### Open the App Templates and select **OK Google**

![](/uploads/2018/05/10/Screen Shot 2018-05-09 at 8.25.43 PM.png)

#### Fill in all the details for the service

![](/uploads/2018/05/10/Screen Shot 2018-05-09 at 8.29.02 PM.png)

#### The container should be running.  

![](/uploads/2018/05/10/Screen Shot 2018-05-09 at 8.29.12 PM.png)

#### Check the logs

![](/uploads/2018/05/10/Screen Shot 2018-05-09 at 8.30.06 PM.png)