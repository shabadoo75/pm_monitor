#!/bin/bash

path=$HOME
path=${path//\//\\\/}
sedcmd="s/$path\/.datadog-agent/\/opt\/datadog-agent/g"

for i in /opt/datadog-agent/venv/bin/*;
do
    echo $i
    sudo sed -i $sedcmd $i
done
