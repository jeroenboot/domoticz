

## MQTT Message Prefixes

| Message  | Intent                                              |
| -------- | ----------------------------------------------------|
| cmnd | control the Sonoff; set configuration; ask for status   |
| stat | report back status or configuration message             |
| tele | report unsolicited telemetry info at periodic intervals |


zie ook;
https://github.com/arendst/Sonoff-Tasmota/wiki/commands


## Naming

| type| naamgeving|topic|
|-----|---------|------|
| S20 | sonoffsw<#> |%prefix%/%topic%/ |
|4channel | sonoff4ch<#> |%prefix%/%topic%/ |




## voorbeeld integratie met Domoticz
- IDX13
DHT22 via Tasmota

- IDX14 - Relais via Tasmota

### inschakelen
#### In Domoticz
On action:
```
script://mqtt.sh 192.168.5.30 domoticz/idx14/out 1
```

Off Action:
```
script://mqtt.sh 192.168.5.30 domoticz/idx14/out 0
```

#### In node-red

Status
```
stat/sonoffsw1/RESULT {"POWER":"ON"}
stat/sonoffsw1/POWER ON
```
### telemetrie
#### Temperature en Humidity
*Voorbeeld*
```
tele/sonoffsw1/SENSOR {
  "Time":"2019-10-06T14:27:15",
  "AM2301":{
    "Temperature":21.7,
    "Humidity":59.1
    },
    "TempUnit":"C"}
```



## voorbeelden (MQTT messages)

### power (Sonoff 4channel)
tele/sonoff4ch/STATE
{
  "Time":"2019-10-06T12:50:02"
  "Uptime":"6T17:46:56"
  "Heap":15,
  "SleepMode":"Dynamic",
  "Sleep":50,
  "LoadAvg":19,
  "POWER1":"OFF",
  "POWER2":"OFF",
  "POWER3":"OFF",
  "POWER4":"OFF",
  "Wifi":{
    "AP":2,
    "SSId":"MOOS-TP",
    "BSSId":"6C:70:9F:DB:C9:D8",
    "Channel":11,
    "RSSI":44,
    "LinkCount":1,
    "Downtime":"0T00:00:10"
  }
}


### Relais/power (S20)
tele/sonoffsw1/STATE
  {
    "Time":"2019-10-06T12:46:16",
    "Uptime":"0T00:04:16",
    "Heap":15,
    "SleepMode":"Dynamic",
    "Sleep":50,
    "LoadAvg":19,
    "POWER":"ON",
    "Wifi":{
      "AP":1,
      "SSId":"Moos-Guest",
      "BSSId":"BC:30:7E:16:59:71",
      "Channel":1,
      "RSSI":80,
      "LinkCount":1,
      "Downtime":"0T00:00:06"
    }
}


### DHT22 sensor (S20)
tele/sonoffsw1/SENSOR
{
  "Time":"2019-10-06T12:49:46"
  "AM2301":{
    "Temperature":21.5,
    "Humidity":60.1},
    "TempUnit":"C"
  }
