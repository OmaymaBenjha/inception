#!/bin/sh
set -e

USER_CLEAN=$FTP_USER
PWD_CLEAN=$FTP_PWD


    

if ! id "$USER_CLEAN" &>/dev/null; then
    useradd -m -d /var/www/html -s /bin/bash "$USER_CLEAN"
fi

echo "${USER_CLEAN}:${PWD_CLEAN}" | chpasswd

chown -R "$USER_CLEAN":"$USER_CLEAN" /var/www/html


exec proftpd -n