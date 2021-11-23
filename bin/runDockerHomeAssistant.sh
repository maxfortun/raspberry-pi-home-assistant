#!/bin/bash -ex

docker stop home-assistant || true
docker rm home-assistant || true

docker run -d \
	--privileged \
	--restart=unless-stopped \
	-v "/etc/localtime:/etc/localtime:ro" \
	-v "$HOME/.config/homeassistant:/config" \
	--network=host \
	--name home-assistant \
	ghcr.io/home-assistant/raspberrypi4-homeassistant:stable
