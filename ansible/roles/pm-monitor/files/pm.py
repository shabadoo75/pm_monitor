import serial, time
import datadog
import os
import subprocess
import sys
import signal
import socket
from datetime import datetime
import gpiozero


from board import SCL, SDA
import busio
from PIL import Image, ImageDraw, ImageFont
import adafruit_ssd1306

#serial port used by the PM meter
pm_ser = serial.Serial('/dev/ttyUSB0')

dd_options = {
    'api_key': os.getenv('DD_API_KEY'),
    'app_key': os.getenv('DD_APP_KEY')
}

datadog.initialize(**dd_options)

def post_to_datadog(pm25, pm10):

  try:
    datadog.api.Metric.send(metric='home.pm25', points=(pm25), host=socket.gethostname(), tags=['location:home', 'environment:production'])
    datadog.api.Metric.send(metric='home.pm10', points=(pm10), host=socket.gethostname(), tags=['location:home', 'environment:production'])
  except Exception as e:
    print(f"send to datadog failed {repr(e)}")

def display_on_screen(pm25, pm10):
  # Draw a black filled box to clear the image.
  draw.rectangle((0, 0, width, height), outline=0, fill=0)

  # First define some constants to allow easy resizing of shapes.
  padding = -2
  top = padding
  bottom = height-padding
  
  # Load font.
  font = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf', 10)

  time = datetime.now().strftime('%H:%M:%S')

  draw.text((0, top+0),  f"Time ---> {time}", font=font, fill=255)
  draw.text((0, top+11), f"PM --->2.5: {PM25}", font=font, fill=255)
  draw.text((0, top+22), f"PM ---> 10: {PM10}", font=font, fill=255)
 
  # Display image.
  disp.image(image)
  disp.show()

def init_screen():

  # Create the I2C interface.
  i2c = busio.I2C(SCL, SDA)
   
  # Create the SSD1306 OLED class.
  # The first two parameters are the pixel width and pixel height.  Change these
  # to the right size for your display!
  disp = adafruit_ssd1306.SSD1306_I2C(128, 32, i2c)
   
  # Clear display.
  disp.fill(0)
  disp.show()
   
  # Create blank image for drawing.
  # Make sure to create image with mode '1' for 1-bit color.
  width = disp.width
  height = disp.height
  image = Image.new('1', (width, height))
   
  # Get drawing object to draw on image.
  draw = ImageDraw.Draw(image)

  return(disp, draw, width, height, image)


disp, draw, width, height, image = init_screen()

while True:

  data = []

  for index in range(0,10):
    datum = pm_ser.read()
    data.append(datum)

  pm25 = int.from_bytes(b''.join(data[2:4]), byteorder='little') / 10
  pm10 = int.from_bytes(b''.join(data[4:6]), byteorder='little') / 10

  print(f"pm2.5: {pm25}\npm10: {pm10}\n")
  post_to_datadog(pm25, pm10)
  display_on_screen(pm25, pm10)

  time.sleep(60)
