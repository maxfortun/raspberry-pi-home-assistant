# raspberry-pi-home-assistant

## Hardware
### HUSBZB
https://www.nortekcontrol.com/products/2gig/husbzb-1-gocontrol-quickstick-combo/

- Plug into USB2 port by the edge of the board  
```bash
ln -s /dev/serial/by-id/usb-Silicon_Labs_HubZ_Smart_Home_Controller_90F00149-if00-port0 /dev/zwave
```

### Z-Stick Gen5
https://aeotec.com/z-wave-usb-stick/index.html  

- Plug into USB3 port by ethernet port
```bash
ln -s /dev/serial/by-id/usb-0658_0200-if00 /dev/zwave
```

## Software
### Docker
Container runtime for applications
#### Installation
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### Z-Wave JS
Z Wave JS Driver
#### Configuration
```bash
mkdir -p $HOME/.config/zwave-js
```

### Home Assistant
Home Automation suite
#### Configuration
```bash
mkdir -p $HOME/.config/homeassistant
```

### Rhasspy
Voice-to-text and text-to-voice suite
#### Configuration
```bash
mkdir -p $HOME/.config/rhasspy/profiles
```
