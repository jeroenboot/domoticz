# Easy esp
```
$ ls /dev/cu.*                           
/dev/cu.Bluetooth-Incoming-Port /dev/cu.SLAB_USBtoUART          /dev/cu.usbserial-0001

$sudo python ./esptool.py --baud 115200 --port /dev/cu.SLAB_USBtoUART write_flash -fm dio 0x00000  /Users/jeroen/Downloads/ESPEasy_mega-20191003/bin/ESP_Easy_mega-20191003_normal_ESP8266_4M1M.bin



```

## Naming

| type| naamgeving|
|-----|---------|
| S20 | sonoffsw<#> |
| Oled ESP| espoled<#> |


### Config
- unitname (lowercase)
- unitnumber
- append
- d1mini<#> | sonoffsw<#> | sonoffss<#> | lolin
- Moos-Guest
- Allow All

### Controllers
- Domoticz MQTT (192.168.5.30)
- Use IP
- Enable
- Controller Subscribe $hostname/in (e.g. sonoffsw7/in)
- Controller Publish $hostname/out


### Devices
- SonOff S20
device | name | GPIO | Values
-----|------|-------|--------
Switch|GPIO0|GPIO0|Sw0
Switch|GPIO12|GPIO12|Sw12
Switch|GPIO13|GPIO13|Sw13
Generic MQTT import | MQTT | Topic1: $hostname/in | MQTTCMD



- ESP Oled

#### Oled

I2C: GPIO5 (SDA) GPIO4 (SCL)

Device: Display - SSD1306
name: OLED
I2C address: 0x3c
Display button: GPIO14 (D5)

| line| description|
|-----|---------|
line1 | Temp: [DHT22#Temperature] C
line2 | Hum:  [DHT22#Humidity] %
line3 | CO2:  [CO2#PPM]  ppm
line4 |
line5 | %sysname%
line6 | %sysday%-%sysmonth%-%sysyear%
line7 | %ssid% %rssi% dBm
line8 | %ip%


Rules:
```
on CO2#PPM do
  Publish ESPEASY/ESP_OLED1/IN,{"idx":51,"nvalue":[CO2#PPM]}
endon


on A0-INTERNAL#ANALOG do
  Publish ESPEASY/ESP_OLED1/IN,{"idx":69,"svalue":"[A0-INTERNAL#ANALOG]"}
endon
````

#### CO2 (MH-Z19)

Device: Gases - CO2 MH-Z19
name: CO2
1st GPIO: GPIO-0 (D3)
2nd GPIO: GPIO-2 (D4)
ABC: Normal
Filter: Skip Unstable

1: PPM
2: Temp
3: PWM



### Advanced  
- rules
- nl.pool.ntp.org
- +60 offset
- 52,64
- 5,05


### MQTT

Topic: e.g. sonoffsw7/in
```
mosquitto_pub -t 'sonoffsw7/in' -m '2'  
```

```
on MQTT#MQTTCMD=0 do //Off
    gpio,13,1
    gpio,12,0
endon

on MQTT#MQTTCMD=1 do // ON
    gpio,13,0
    gpio,12,1
endon

on MQTT#MQTTCMD=2 do //Toggle
  if [GPIO13#Sw13]=0
    gpio,13,0
    gpio,12,1
  else
    gpio,13,1
    gpio,12,0
  endif
endon
```


### rules
*Voorbeelden:*

```
// opstarten met relais "aan"
On System#Boot do    //When the ESP boots, do
    gpio,13,0 // led aan
    gpio,12,1 // relais aan
endon


// knopje op SonOff S20
on GPIO0#Sw0=1 do
  if [GPIO12#Sw12]=0 //als uit, relais is uit, do aanzetten
    gpio,13,0 // groene led aan
    gpio,12,1 // relais aan
  else
    gpio,13,1
    gpio,12,0
  endif
endon



// event op basis vijn tijd
on Clock#Time=All,19:15 do
    gpio,13,1 // led uit
    gpio,12,0 // relais uit
endon

on Clock#Time=All,20:00 do
    gpio,13,0 // led aan
    gpio,12,1 // relais aan
endon
```
