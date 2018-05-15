#!/usr/bin/env sh

echo '' > /etc/.env
env | grep _ >> /etc/.env

echo "PermitOpen $GLAGOL_DNS:51151" >> /etc/ssh/sshd_config

ssh-keygen -A -t rsa

exec /usr/sbin/sshd -D -e "$@"
