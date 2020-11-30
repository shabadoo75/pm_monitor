#!/bin/bash

echo "Welcome to the Raspberry Pi particle monitor setup!"
echo
echo

echo "Installing Ansible"
sudo apt-get update
sudo apt-get -y install ansible
echo
echo

echo "Now we need some configuration details for your particle monitor"
echo

read -e -p "Hostname for the Pi: " -i "pm-monitor" hostname

read -e -p "Do you have a Adafruit PiOLED display? [Y/N]: " -i "N" has_display
has_display=$(echo $has_display | tr [A-Z] [a-z] | sed 's/y/yes/' | sed 's/n/no/')

read -e -p "datadog API key: " -i "" dd_api_key

read -e -p "datadog app key: " -i "" dd_app_key

echo

echo "****************************"
echo "Configuration values:"
echo "Hostname: $hostname"
echo "Display: $has_display"
echo "datadog API key: $dd_api_key"
echo "datadog app key: $dd_app_key"
echo "****************************"
echo

read -e -p "Look good? start the install [Y/N]: " -i "N" install
if [[ "$install" = "Y" || "$install" = "y" ]]; then
  echo "starting..."
else
  echo "exit"
  exit 0
fi


ansible-playbook -u pi \
    -e "hostname=$hostname" \
    -e "DD_API_KEY=$dd_api_key" \
    -e "DD_APP_KEY=$dd_app_key" \
    -e "has_display=$has_display" \
    ansible/playbook.yml
