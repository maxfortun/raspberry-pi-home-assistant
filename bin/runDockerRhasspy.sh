#!/bin/bash -ex

docker container stop rhasspy || true
docker container rm rhasspy || true
docker run -d \
	--restart=unless-stopped \
	--device /dev/snd:/dev/snd \
	-p 12101:12101 \
	-v "$HOME/.config/rhasspy/profiles:/profiles" \
	-v "/etc/localtime:/etc/localtime:ro" \
	--name rhasspy \
	rhasspy/rhasspy \
	--user-profiles /profiles \
	--profile en
