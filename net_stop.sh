#!/bin/bash

NAME=$1

echo $NAME

PID=`docker inspect -f '{{.State.Pid}}' ${NAME}`

ip netns exec ${PID} dhcpcd -k ${NAME} || true

sleep 5
