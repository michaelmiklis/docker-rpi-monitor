# About this Repo

This is the Git repo of the Docker image for [rpi-monitor](https://hub.docker.com/r/michaelmiklis/rpi-monitor/). 
See [the Docker Hub page](https://hub.docker.com/r/michaelmiklis/rpi-monitor/) for the full readme on how to use this Docker 
image and for information regarding contributing and issues.

docker-rpi-monitor
========
RPi-Monitor from [RPi-Experiences](http://rpi-experiences.blogspot.de/p/rpi-monitor.html) is an easy and free to use WebUI to
monitor your Raspberry PI.

To run the docker-rpi-monitor image and monitor your physical Raspberry PI instead of the docker container itself, a lot of
volumes needs to be mapped into the container:

	/opt/vc
	
	/boot
	
	/sys
	
	/etc
	
	/proc
	
	/usr/lib
	

All volumes are mapped as read-only to ensure the container can't modify the data on the docker host. Additionally access to
the Raspberry PI's vchiq and vcsm device needs to be mapped to the container to access hardware sensors, like CPU Temperature, e.g.

Quickstart
----------
	docker run --device=/dev/vchiq --device=/dev/vcsm --volume=/opt/vc:/opt/vc --volume=/boot:/boot --volume=/sys:/dockerhost/sys:ro --volume=/etc:/dockerhost/etc:ro --volume=/proc:/dockerhost/proc:ro --volume=/usr/lib:/dockerhost/usr/lib:ro -p=8888:8888 --name="rpi-monitor" -d  michaelmiklis/rpi-monitor:latest
	
Access
----------
After a successful start you can access the RPi-Monitor using http://dockerhost-ip:8888