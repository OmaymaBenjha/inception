#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld --user=mysql --bootstrap <<EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`$SQL_DB\`;
CREATE USER IF NOT EXISTS '$SQL_USR'@'%' IDENTIFIED BY '$SQL_PWD';
GRANT ALL PRIVILEGES ON \`$SQL_DB\`.* TO '$SQL_USR'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PWD';
FLUSH PRIVILEGES;
EOF

exec mysqld --user=mysql --port=3306 --bind-address=0.0.0.0