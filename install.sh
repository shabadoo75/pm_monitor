#!/bin/bash

echo "Welcome to the Raspberry Pi particle monitor setup!"
echo
echo

echo "Installing Ansible"
sudo apt-get update
sudo apt-get -y install ansible
echo
echo

read -e -p "Hostname for the Pi: " -i "pm_monitor" hostname

read -e -p "datadog API key: " -i "" dd_api_key

read -e -p "datadog app key: " -i "" dd_app_key

echo

echo "****************************"
echo "Configuration values:"
echo "Hostname: $hostname"
echo "datadog API key: $dd_api_key"
echo "datadog app key: $dd_app_key"
echo "****************************"
echo

read -e -p "Looks good, start the install? [Y/N]: " -i "N" install
if [ "$install" = "Y" ]; then
  echo "starting..."
else
  echo "exit"
  exit 0
fi

ansible-playbook -u pi \
    -e "hostname=$hostname" \
    -e "DD_API_KEY=$dd_api_key" \
    -e "DD_APP_KEY=$dd_app_key" \
    ansible/playbook.yml
