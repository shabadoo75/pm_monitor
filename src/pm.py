import serial, time

ser = serial.Serial('/dev/ttyUSB0')

while True:

  data = []

  for index in range(0,10):
    datum = ser.read()
    data.append(datum)


  pm25 = int.from_bytes(b''.join(data[2:4]), byteorder='little') / 10
  pm10 = int.from_bytes(b''.join(data[4:6]), byteorder='little') / 10

  print(f"pm2.5: {pm25}\npm10: {pm10}")
  time.sleep(10)
