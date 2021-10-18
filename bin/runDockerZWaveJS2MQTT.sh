#!/bin/bash -ex

docker container stop zwavejs2mqtt || true
docker container rm zwavejs2mqtt || true
docker run -d \
	--restart=unless-stopped \
	--device=/dev/zwave:/dev/zwave \
	-p 3000:3000 \
	-p 8091:8091 \
	-v "$HOME/.config/zwave-js:/usr/src/app/store" \
	--name=zwavejs2mqtt \
	zwavejs/zwavejs2mqtt
