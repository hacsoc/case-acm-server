#!/bin/bash
set -ex -o pipefail

NAME=$1

PID=`docker inspect -f '{{.State.Pid}}' ${NAME}`

ip netns exec ${PID} dhcpcd -k ${NAME} || true

/usr/local/bin/docker-compose -f /srv/acm/${NAME}.yml stop

rm /var/run/netns/${PID}

/usr/bin/docker rm $(/usr/local/bin/docker-compose -f /srv/acm/${NAME}.yml ps -q) || true
