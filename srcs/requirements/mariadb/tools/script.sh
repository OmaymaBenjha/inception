#!/bin/bash

mkdir -p /run/mysqld

chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql --bootstrap < /tmp/db.sql

	cat << EOF > /tmp/db.sql
	CREATE DATABASE IF NOT EXISTS $SQL_DB;
	CREATE USER IF NOT EXISTS '$SQL_USR'@'%' IDENTIFIED BY '$SQL_PWD';
	GRANT ALL PRIVILEGES  ON $SQL_DB.* TO '$SQL_USR'@'%';
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PWD';
	FLUSH PRIVILEGES;
EOF

	/usr/sbin/mysqld --user=mysql --bootstrap < /tmp/db.sql

	rm -f /tmp/db.sql
fi

exec /usr/sbin/mysqld --user=mysql

