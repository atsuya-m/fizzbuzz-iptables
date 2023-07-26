#!/bin/bash -x

iptables -F

# ICMP エコー要求パケットを ICMP_CHAIN に飛ばす
iptables -A OUTPUT -j LOG --log-prefix "OUTPUT"
iptables -A OUTPUT -p icmp --icmp-type 8 -j ICMP_CHAIN
# アドレスリストを作成または更新
iptables -A ICMP_CHAIN -m recent --name fizz --set
# ヒット数が3に達したら FIZZ に飛ばす
iptables -A ICMP_CHAIN -m recent --name fizz --rcheck --hitcount 3 -j FIZZ
# アドレスリストをリセットし、リジェクトする
iptables -A FIZZ -j LOG --log-prefix "FIZZ"
iptables -A FIZZ -m recent --name fizz --remove -j REJECT

iptables-save | iptables-restore
