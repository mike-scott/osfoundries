+++
date = "2018-05-08"
draft = true
title = "Portainer Container Management on Linux microPlatform "

+++
At Open Source Foundries, we are constantly looking across the ecosystem  for the best projects to complement the microPlatforms.  One such project is [Portainer](https://portainer.io "Portainer"). "Portainer is an open-source lightweight management UI which allows you to easily manage your Docker hosts or swarm clusters.

<!--more-->

You can easily try out portainer and some of our experimental containers by ssh'ing into a system running the Linux microPlatform and running

    docker run -d -p 9000:9000 --restart always --name portainer  -v $PWD/data:/data -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer --logo https://foundries.io/static/img/logo.png --templates https://raw.githubusercontent.com/OpenSourceFoundries/ez/master/templates.json

![](/uploads/2018/05/08/runportainer.png)

After you get the service running, you can then access the portainer UI:

![](/uploads/2018/05/08/create-account.png)

Connect to the Local device:

![](/uploads/2018/05/08/connect-local.png)

"Connect"

![](/uploads/2018/05/08/connect-locally.png)

Now you have access to the Portainer UI.  From here you can create, refresh, stop, start re-create, inspect all of the containers running on your device.

![](/uploads/2018/05/08/front-page.png)

You can also try out some sample 'experimental' apps that we are compiling to demonstrate the ease of using containers to 'contain' an application, allowing for simplicity when updating the baseOS using OTA community edition.

![](/uploads/2018/05/08/experimental-apps.png)