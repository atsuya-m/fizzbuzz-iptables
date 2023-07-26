#!/bin/bash -x

iptables -F

iptables -N RESET_CHAIN
iptables -N COUNTER_CHAIN
iptables -N LOGIC_CHAIN
iptables -N NOTHING
iptables -N FIZZ
iptables -N BUZZ
iptables -N FIZZBUZZ

iptables -A OUTPUT -p icmp --icmp-type 8 -j RESET_CHAIN
iptables -A OUTPUT -p icmp --icmp-type 8 -j COUNTER_CHAIN
iptables -A OUTPUT -p icmp --icmp-type 8 -j LOGIC_CHAIN

iptables -A RESET_CHAIN -m u32 ! --u32 "0>>22&0x3C@6>>16=0x01" -j RETURN
iptables -A RESET_CHAIN -m recent --name fizz      --remove
iptables -A RESET_CHAIN -m recent --name buzz      --remove
iptables -A RESET_CHAIN -m recent --name fizzbuzz  --remove

iptables -A COUNTER_CHAIN -m recent --name fizz     --set
iptables -A COUNTER_CHAIN -m recent --name buzz     --set
iptables -A COUNTER_CHAIN -m recent --name fizzbuzz --set

iptables -A LOGIC_CHAIN -m recent --name fizzbuzz --rcheck --hitcount 15 -j FIZZBUZZ
iptables -A LOGIC_CHAIN -m recent --name buzz     --rcheck --hitcount 5  -j BUZZ
iptables -A LOGIC_CHAIN -m recent --name fizz     --rcheck --hitcount 3  -j FIZZ
iptables -A LOGIC_CHAIN                                                  -j NOTHING

iptables -A FIZZBUZZ -m recent --name fizzbuzz --remove -j REJECT --reject-with icmp-port-unreachable  # CODE = 3
iptables -A BUZZ     -m recent --name buzz     --remove -j REJECT --reject-with icmp-proto-unreachable # CODE = 2
iptables -A FIZZ     -m recent --name fizz     --remove -j REJECT --reject-with icmp-host-unreachable  # CODE = 1
iptables -A NOTHING                                     -j REJECT --reject-with icmp-net-unreachable   # CODE = 0

iptables-save | iptables-restore
