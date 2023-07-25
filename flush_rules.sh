#!/bin/bash -x

iptables -F OUTPUT
iptables-save | iptables-restore
