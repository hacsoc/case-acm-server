#!/bin/bash

NAME=$1

echo $NAME

PID=`docker inspect -f '{{.State.Pid}}' ${NAME}`

ip netns exec ${PID} dhcpcd -k ${NAME} || true

/usr/local/bin/docker-compose -f /srv/acm/${NAME}.yml stop

rm /var/run/netns/${PID}

/usr/bin/docker rm $(/usr/local/bin/docker-compose -f /srv/acm/${NAME}.yml ps -q)
