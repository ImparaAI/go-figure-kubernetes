#!/bin/sh

if [ -f "/ssh/id_rsa" ]; then
  mkdir /root/.ssh
  cp /ssh/id_rsa /root/.ssh/id_rsa
  chmod -R 700 /root/.ssh/id_rsa
  echo "    IdentityFile ~/.ssh/id_rsa" >> /root/.ssh/config
fi

touch /var/healthy

while :; do
  sleep 1
done