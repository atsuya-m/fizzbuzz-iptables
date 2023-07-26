#!/bin/bash -x

iptables -F
iptables-save | iptables-restore
