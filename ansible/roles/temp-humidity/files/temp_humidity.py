# SPDX-FileCopyrightText: Copyright (c) 2020 Bryan Siepert for Adafruit Industries
#
# SPDX-License-Identifier: MIT
import time
import board
import adafruit_shtc3
import datadog
import os
import socket

def post_to_datadog(temperature, humidity):

  try:
    datadog.api.Metric.send(metric='home.temperature', points=(temperature), host=socket.gethostname(), tags=['location:home', 'environment:production'])
    datadog.api.Metric.send(metric='home.humidity', points=(humidity), host=socket.gethostname(), tags=['location:home', 'environment:production'])
  except Exception as e:
    print(f"send to datadog failed: {e}")

i2c = board.I2C()
sht = adafruit_shtc3.SHTC3(i2c)

dd_options = {
    'api_key': os.getenv('DD_API_KEY'),
    'app_key': os.getenv('DD_APP_KEY')
}

datadog.initialize(**dd_options)

temperature, humidity = sht.measurements
post_to_datadog(temperature, humidity)

