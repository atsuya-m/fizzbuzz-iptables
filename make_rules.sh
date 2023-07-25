#!/bin/bash -x

iptables -F OUTPUT
iptables -A OUTPUT -s 192.168.0.103 -d 192.168.0.103 -p icmp --icmp-type 8 -m length --length 38 -j REJECT --reject-with icmp-host-unreachable

iptables-save | iptables-restore
