#!/bin/bash -ex

docker stop wireguard || true
docker rm wireguard || true

if [ -z "$SERVERURL" ]; then
	SERVERURL="$(host myip.opendns.com resolver1.opendns.com|tail -1|awk '{ print $4 }')"
fi

ifs="eth0 wlan0"
for if in $ifs; do
	read inet_ inet netmask_ netmask broadcast_ broadcast < <( ifconfig $if | grep "inet " || true ) || true
	if [ -n "$broadcast" ]; then
		break
	fi
done

if [ -z "$broadcast" ]; then
	echo "Failed to find a working network interface among $ifs"
	exit 1
fi

if [ -z "$INTERNAL_SUBNET" ]; then
	INTERNAL_SUBNET=$(ipcalc -nb $inet|grep ^Network:|awk '{ print $2 }'|sed 's/\/.*$//g')
fi

docker run -d \
	--name=wireguard \
	--cap-add=NET_ADMIN \
	--cap-add=SYS_MODULE \
	-e PUID=1000 \
	-e PGID=1000 \
	-e SERVERURL=$SERVERURL `#optional` \
	-e SERVERPORT=51820 `#optional` \
	-e PEERS=1 `#optional` \
	-e PEERDNS=auto `#optional` \
	-e INTERNAL_SUBNET=10.13.13.0 `#optional` \
	-e ALLOWEDIPS=0.0.0.0/0 `#optional` \
	-p 51820:51820/udp \
	-v "/etc/localtime:/etc/localtime:ro" \
	-v "$HOME/.config/wireguard:/config" \
	-v /lib/modules:/lib/modules \
	--sysctl="net.ipv4.conf.all.src_valid_mark=1" \
	--restart=unless-stopped \
	lscr.io/linuxserver/wireguard


