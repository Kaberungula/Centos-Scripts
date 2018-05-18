#!/bin/bash

# First argument: Client identifier

KEY_DIR=/etc/openvpn/keys/easy-rsa-master/easyrsa3/pki/clients
OUTPUT_DIR=/etc/openvpn/client-configs/files
BASE_CONFIG=/etc/openvpn/client-configs/base.conf

cat ${BASE_CONFIG} \
<(echo -e '<ca>') \
${KEY_DIR}/ca.crt \
<(echo -e '</ca>\n<cert>') \
${KEY_DIR}/${1}.crt \
<(echo -e '</cert>\n<key>') \
${KEY_DIR}/${1}.key \
<(echo -e '</key>') \
> ${OUTPUT_DIR}/${1}.ovpn
