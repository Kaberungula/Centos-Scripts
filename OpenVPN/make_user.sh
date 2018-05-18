#!/bin/bash.sh

pass=$(openssl rand -base64 10)
client=''
echo "Set password on certificate":   $pass
while [ "$client" = "" ]; do
        echo -n "Input username for client: "
        read client
done

/etc/openvpn/keys/easy-rsa-master/easyrsa3/easyrsa gen-req $client
sleep 1
/etc/openvpn/keys/easy-rsa-master/easyrsa3/easyrsa sign-req client $client
sleep 1
mv /etc/openvpn/keys/easy-rsa-master/easyrsa3/pki/issued/$client.crt /etc/openvpn/keys/easy-rsa-master/easyrsa                                                                                                                               3/pki/clients/
mv /etc/openvpn/keys/easy-rsa-master/easyrsa3/pki/private/$client.key /etc/openvpn/keys/easy-rsa-master/easyrs                                                                                                                               a3/pki/clients/

/etc/openvpn/client-configs/make_config.sh $client

echo $client $pass >> /etc/openvpn/client-configs/files/clients-pass.txt
echo 'push "redirect-gateway def1 bypass-dhcp"' > /etc/openvpn/ccd/$client
echo "User" $client "create successfully!"
echo "Suggested password:" $pass
echo "Data - account, password, stored at: cat /etc/openvpn/client-configs/files/clients-pass.txt"
