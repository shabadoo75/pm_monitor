#!/bin/bash

cd /opt/datadog-agent/venv/local/

for i in *;
do
    echo $i
    rm $i && ln -s ../$i $i
done
