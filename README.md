# pm_monitor
Setup a raspberry pi to monitor and report on PM air quality. Based on https://www.raspberrypi.org/blog/monitor-air-quality-with-a-raspberry-pi/


```
ansible-playbook -i hosts -u pi -k -e "hostname=pm-monitor" -e "DD_API_KEY=$DD_API_KEY" -e "DD_APP_KEY=$DD_APP_KEY" ansible/playbook.yml
```
