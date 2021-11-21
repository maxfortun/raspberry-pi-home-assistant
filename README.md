# raspberry-pi-home-assistant

## Hardware
### HUSBZB
https://www.nortekcontrol.com/products/2gig/husbzb-1-gocontrol-quickstick-combo/

> Plug into USB2 port by the edge of the board  
```shell
sudo ln -s /dev/serial/by-id/usb-Silicon_Labs_HubZ_Smart_Home_Controller_90F00149-if00-port0 /dev/zwave
```

### Z-Stick Gen5
https://aeotec.com/z-wave-usb-stick/index.html  

> Plug into USB3 port by ethernet port
```shell
sudo ln -s /dev/serial/by-id/usb-0658_0200-if00 /dev/zwave
```

## Software

### Docker
Container runtime for applications

#### Installation
```shell
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### Z-Wave JS
Z Wave JS Driver

#### Prerequisites
* Hardware

#### Configuration
```shell
mkdir -p $HOME/.config/zwave-js
```

#### Run
```shell
bin/runDockerZWaveJS2MQTT.sh
```


### Home Assistant
Home Automation suite

#### Prerequisites
* Z-Wave JS

#### Configuration
```shell
mkdir -p $HOME/.config/homeassistant
```
#### Run
```shell
bin/runDockerHomeAssistant.sh
```

### WireGuard
VPN

#### Configuration
```shell
mkdir -p $HOME/.config/wireguard
```

#### Run
```shell
bin/runDockerWireGuard.sh
```

#### WAN
Forward port 51820 from your router to your raspberry pi ip

### Rhasspy
Voice-to-text and text-to-voice suite
#### Configuration
```shell
mkdir -p $HOME/.config/rhasspy/profiles
```

#### Run
```shell
bin/runDockerWireGuard.sh
```


