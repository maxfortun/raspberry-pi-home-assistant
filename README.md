# raspberry-pi-home-assistant

## Hardware

### HUSBZB
https://www.nortekcontrol.com/products/2gig/husbzb-1-gocontrol-quickstick-combo/  
Protocols: Z-Wave, Zigbee  

> Plug into USB2 port by the edge of the board  
```shell
sudo sed -i 's#^exit 0#ln -s /dev/serial/by-id/usb-Silicon_Labs_HubZ_Smart_Home_Controller_90F00149-if00-port0 /dev/zwave\nexit 0#' /etc/rc.local 
sudo /etc/rc.local 
```

### Z-Stick Gen5
https://aeotec.com/z-wave-usb-stick/index.html  
Protocols: Z-Wave  

> Plug into USB3 port by ethernet port
```shell
sudo sed -i 's#^exit 0#ln -s /dev/serial/by-id/usb-0658_0200-if00 /dev/zwave\nexit 0#' /etc/rc.local 
sudo /etc/rc.local 
```

### L-BDGPRO2-WH
https://www.casetawireless.com/proproducts
Supports Lutron Caseta devices  
Protocols: Clear Connect RF  


## Software

### Docker
Container runtime for applications

#### Installation
```shell
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker pi
```

### Z-Wave JS
Z Wave JS Driver

#### Prerequisites
* Hardware
* Docker

#### Configuration
```shell
mkdir -p $HOME/.config/zwave-js
```

1. Point your browser to http://ip.of.the.pi:8091/settings
1. Disable MQTT Gateway
1. Enable WS Server
1. Scroll all the way down and click save in the lower right corner

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

1. Point your browser to http://ip.of.the.pi:8123/config/integrations
1. Click `ADD INTEGRATION` in lower right corner
1. Select Z-Wave JS
1. Save

### WireGuard
VPN

#### Configuration
```shell
mkdir -p $HOME/.config/wireguard
sudo apt install -y ipcalc
```

#### Run
```shell
bin/runDockerWireGuard.sh
```

#### WAN
1. Set your raspberry pi ip to static
```shell
ip=$(ifconfig wlan0|grep "inet "|awk '{ print $2 }')
router=$(netstat -nr | grep ^0.0.0.0|awk '{ print $2 }')

cat <<_EOT_ | tee -a /etc/dhcpcd.conf

interface wlan0
static ip_address=$ip/24
static routers=$router
static domain_name_servers=$router 8.8.8.8

_EOT_

```
Verify that values on the screen are reasonable, then reboot.

2. Forward port 51820 from your router to your raspberry pi ip

#### Setup clients
Specify a peer/client id that you want to setup in variable `PEER_ID`.

```shell
PEER_ID=1
docker exec -it wireguard /app/show-peer $PEER_ID
```

Download and install a WireGuard app to your `camera-enabled device`, then use it to scan the QR code displayed by the above command.


### Rhasspy
Voice-to-text and text-to-voice suite
#### Configuration
```shell
mkdir -p $HOME/.config/rhasspy/profiles
```

#### Run
```shell
bin/runDockerRhasspy.sh.sh
```


