#!/usr/bin/env sh

echo '' > /etc/.env
echo "DB_HOST=$DB_HOST" >> /etc/.env
echo "DB_DATABASE=$DB_DATABASE" >> /etc/.env
echo "DB_USERNAME=$DB_USERNAME" >> /etc/.env
echo "DB_PASSWORD=$DB_PASSWORD" >> /etc/.env

echo "PermitOpen $GLAGOL_DNS:51151" >> /etc/ssh/sshd_config

ssh-keygen -A -t rsa

exec /usr/sbin/sshd -D -e "$@"
