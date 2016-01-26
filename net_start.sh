#!/bin/bash

mkdir -p /var/run/netns/

NAME=$1

MAC=`cat /srv/acm/${NAME}/MAC`
sleep 1

PID=0
while [[ PID -eq 0 ]]; do
    PID=`docker inspect -f '{{.State.Pid}}' ${NAME}`
    sleep 1
done
sleep 1

ln -s /proc/${PID}/ns/net /var/run/netns/${PID}
ls /var/run/netns
sleep 1

ip link add ${NAME} link eth0 address ${MAC} type macvlan mode bridge
sleep 1
ip link set ${NAME} netns ${PID} 
sleep 1
ip netns exec ${PID} ip route del default
sleep 1
ip netns exec ${PID} ip a
sleep 1
echo "PUTTING UP ${NAME} INTERFACE!!!!!"
ip netns exec ${PID} ip l set dev ${NAME} up
sleep 1
ip netns exec ${PID} dhcpcd ${NAME}

