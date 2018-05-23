#!/bin/bash.sh

addr=$1
dns=$(cat /etc/openvpn/server-tcp.conf | \
grep 'push "dhcp' | awk '{print($4)}' | \
head -n 1 | cut -d '=' -f 2 | head --bytes -2)
outputIP=$(nslookup $addr | grep 'Address' | \
grep -v $dns | grep -v $dns | \
awk '{print($2)}')
echo 'push "route '$outputIP' 255.255.255.255"' \
>> /etc/openvpn/server-tcp.conf
if [ -n "$(sort /etc/openvpn/server-tcp.conf | uniq -d)" ]
then
        echo "Route already exist"
        sed -i '$ d' /etc/openvpn/server-tcp.conf
else
        systemctl restart openvpn@server-tcp
        sleep 1
        echo "IP-address add to route!"
fi
stat=$(systemctl status openvpn@server-tcp | grep active)
echo "Status of vpn-server:" $stat
