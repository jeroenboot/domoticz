#!/bin/bash

MQTTSERVER="$1";
TOPIC="$2";
MESSAGE="$3";

mosquitto_pub -h $MQTTSERVER -t "$TOPIC" -m "$MESSAGE"
