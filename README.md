# Air quality monitor
Setup a Raspberry Pi to monitor and report on PM2.5 and PM10 air quality.

### This project requires
- a rasperry pi, any model
- this particle sensor: https://www.aliexpress.com/item/32606349048.html
- a datadog account, sign up for free: https://www.datadoghq.com/
- optionally this small screen: https://www.littlebird.com.au/products/adafruit-pioled-128x32-monochrome-oled-add-on-for-raspberry-pi


Based on https://www.raspberrypi.org/blog/monitor-air-quality-with-a-raspberry-pi/


## Installation

ssh to the pi you want to use as the monitor

download the code

```
curl -L -O https://github.com/shabadoo75/pm_monitor/archive/master.zip
```

unzip
```
unzip master.zip
```

install
```
cd pm_monitor-master
./install.sh
```
