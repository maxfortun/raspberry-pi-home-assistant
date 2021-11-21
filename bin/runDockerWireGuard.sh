#!/bin/bash -ex

docker stop wireguard || true
docker rm wireguard || true

docker run -d \
	--name=wireguard \
	--cap-add=NET_ADMIN \
	--cap-add=SYS_MODULE \
	-e PUID=1000 \
	-e PGID=1000 \
	-e SERVERURL=wireguard.domain.com `#optional` \
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


