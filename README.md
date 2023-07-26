# fizzbuzz-iptables
fizzbuzz-iptables は、iptables コマンドのみを用いて Fizz-Buzz を解くソルバーです。

# 準備
iptables のルールを上書きします。
```
$ sudo ./make_rules.sh
```
* これにより ping が一切通らなくなります。自己責任でお願いします。

# 入力
```
$ ping localhost -4 -i 0.02 -c {N}
```
`{N}`に任意の自然数を与えます。
あるいは、
```
$ ping localhost -4 -i 0.02 -c 50| awk -v 'OFS=\t' '/^From/ { gsub("Net", "", $6);gsub("Host", "Fizz"); gsub("Protocol", "Buzz"); gsub("Port", "FizzBuzz"); print substr($4, 10), $6 }' > ./result.txt
```
