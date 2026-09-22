#!/bin/sh
set -e

USER_CLEAN=$FTP_USER
PWD_CLEAN=$FTP_PWD

if ! id "$FTP_USER" >/dev/null 2>&1; then
    useradd -m -d /var/www/html -s /bin/bash "$FTP_USER"
fi

echo "${FTP_USER}:${FTP_PWD}" | chpasswd

chown -R "$USER_CLEAN":"$USER_CLEAN" /var/www/html


exec proftpd -n