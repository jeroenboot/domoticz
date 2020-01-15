## Install
```
sudo apt-get install -y git letsencrypt

```

## run

sudo letsencrypt certonly --webroot --email <email> -d <site> -w /home/pi/docker/rpi-domoticz/www
/var/lib/domoticz/www



## renew

###Enable port 80 in FW en NAT
```
sudo letsencrypt certonly --webroot --email <email> -d <site> -w /home/pi/docker/rpi-domoticz/www

sudo mv /home/pi/docker/rpi-domoticz/config/keys/server_cert.pem /home/pi/docker/rpi-domoticz/config/keys/server_cert.pem.org 
sudo cat /etc/letsencrypt/live/<site>/privkey.pem >> /home/pi/docker/rpi-domoticz/config/keys/server_cert.pem
sudo cat /etc/letsencrypt/live/<site>/fullchain.pem >> /home/pi/docker/rpi-domoticz/config/keys//server_cert.pem
sudo cat /home/pi/docker/rpi-domoticz/config/keys/RSA2048.pem >> /home/pi/docker/rpi-domoticz/config/keys/server_cert.pem

sudo cp /home/pi/docker/rpi-domoticz/config/keys/server_cert.pem /home/pi/docker/rpi-domoticz/config/keys/letsencrypt_server_cert.pem
docker restart domoticz
```

###Disable port 80 in FW en NAT