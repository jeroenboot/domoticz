# node-red
Persistent data in 'rpi-nodered/node-red-data'
```
mkdir -p rpi-nodered/node-red-data
cd rpi-nodered/node-red-data

 docker run \
  --name mynodered \
  --restart unless-stopped \
  --detach \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Amsterdam \
  -p 1880:1880 \
  -v $PWD/node-red-data:/data \
  rpihomeautomation/rpinodered
 ```


# domoticz
Persistent data in 'rpi-domoticz/config'
```
mkdir -p rpi-domoticz/config
cd rpi-domoticz/config

docker run \
 --name=domoticz \
 --restart unless-stopped \
 --detach \
 -e PUID=1000 \
 -e PGID=1000 \
 -e TZ=Europe/Amsterdam \
 -p 8080:8080 \
 -p 6144:6144 \
 -p 1443:1443 \
 -v $PWD/config:/config \
 linuxserver/domoticz
```

Add mosquitto_clients to container

```
docker exec -ti domoticz /bin/bash
$ apk add mosquitto-clients
```

mqtt.sh script to sent messages as a script (3 variables used in small mqtt script);



# Mosquitto
No persistent data
```
docker run \
 --name=mosquitto \
 --restart unless-stopped \
 --detach \
 -e PUID=1000 \
 -e PGID=1000 \
 -e TZ=Europe/Amsterdam \
 -p 1883:1883 \
 eclipse-mosquitto
 ```
