# Easy esp

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
Generic MQTT import | MQTT | Topic1: | MQTTCMD



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
