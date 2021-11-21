#!/bin/bash -ex

docker stop home-assistant
docker rm home-assistant
docker run -d \
	--privileged \
	--restart=unless-stopped \
	-v "/etc/localtime:/etc/localtime:ro" \
	-v "$HOME/.config/homeassistant:/config" \
	--network=host \
	--name home-assistant \
	ghcr.io/home-assistant/raspberrypi4-homeassistant:stable
