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

read -e -p "Hostname for the Pi: " -i "pm_monitor" hostname

read -e -p "Do you have a Adafruit PiOLED display?: " -i "N" display
display=$(echo $display | tr [A-Z] [a-z])

read -e -p "datadog API key: " -i "" dd_api_key

read -e -p "datadog app key: " -i "" dd_app_key

echo

echo "****************************"
echo "Configuration values:"
echo "Hostname: $hostname"
echo "Display: $display"
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
    -e "display=$display" \
    ansible/playbook.yml
