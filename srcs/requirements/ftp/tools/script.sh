#!/bin/sh
set -e

# Create the FTP user if it doesn't already exist
if ! id "$FTP_USER" >/dev/null 2>&1; then
    useradd -m -d /home/"$FTP_USER" -s /bin/bash "$FTP_USER"
fi

# Set the user's password
echo "${FTP_USER}:${FTP_PWD}" | chpasswd

# Make sure the shared directory exists
mkdir -p /var/www/html

# Give the FTP user ownership
chown -R "$FTP_USER":"$FTP_USER" /var/www/html

# Create the vsftpd user list
echo "$FTP_USER" > /etc/vsftpd.user_list

# Start the FTP server
exec /usr/sbin/vsftpd /etc/vsftpd.conf