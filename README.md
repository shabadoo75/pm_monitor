# pm_monitor
Setup a raspberry pi to monitor and report on PM air quality. Based on https://www.raspberrypi.org/blog/monitor-air-quality-with-a-raspberry-pi/


```
ansible-playbook -i hosts -u pi -k -e "hostname=pi-host" ansible/playbook.yml
```
