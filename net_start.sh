#!/bin/bash
set -ex -o pipefail

mkdir -p /var/run/netns/

NAME=$1

MAC=`cat /srv/acm/${NAME}/MAC`
sleep 1

PID=0
while [[ PID -eq 0 ]]; do
    PID=`docker inspect -f '{{.State.Pid}}' ${NAME} || echo 0`
    sleep 1
done
sleep 1

if [[ ! -h /var/run/netns/${PID} ]]; then
    ln -s /proc/${PID}/ns/net /var/run/netns/${PID}
    sleep 1
fi

ip link add ${NAME} link eth0 address ${MAC} type macvlan mode bridge
sleep 1
ip link set ${NAME} netns ${PID} 
sleep 1
ip netns exec ${PID} ip route del default || true
sleep 1
ip netns exec ${PID} ip l set dev ${NAME} up
sleep 1
ip netns exec ${PID} dhcpcd -w ${NAME}

