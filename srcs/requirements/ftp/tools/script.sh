#!/bin/sh
set -e

USER_CLEAN=$(echo "$FTP_USER" | tr -d '\r')
PWD_CLEAN=$(echo "$FTP_PWD" | tr -d '\r')


mkdir -p /var/www/html

if ! id "$USER_CLEAN" >/dev/null 2>&1; then
    useradd -m -d /var/www/html -s /bin/bash "$USER_CLEAN"
fi

echo "${USER_CLEAN}:${PWD_CLEAN}" | chpasswd

chown -R "$USER_CLEAN":"$USER_CLEAN" /var/www/html


exec proftpd -n -c /etc/proftpd/proftpd.conf