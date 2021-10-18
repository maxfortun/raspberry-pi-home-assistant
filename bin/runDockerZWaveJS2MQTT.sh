#!/bin/bash -ex

if [ ! -e /dev/zwave ]; then
	cat <<_EOT_
/dev/zwave is missing.
For HUSBZB: 
sudo ln -s /dev/serial/by-id/usb-Silicon_Labs_HubZ_Smart_Home_Controller_90F00149-if00-port0 /dev/zwave

For Z-Stick Gen5:
sudo ln -s /dev/serial/by-id/usb-0658_0200-if00 /dev/zwave

_EOT_
	exit 1
fi

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
