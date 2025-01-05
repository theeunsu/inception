#!/bin/sh

# Load env variables or set defaults if not provided
: "${DB_NAME:=default_database}"
: "${DB_USER:=default_user}" 
: "${DB_PASSWORD:=default_password}" 
: "${DB_ROOT_PASSWORD:=default_root_password}" 

echo "Starting MariaDB initialization..."

# Check and create necessary directories if they are missing
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "MariaDB data directory not found. Initializing..."
    mkdir -p /var/lib/mysql /var/run/mysqld
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

	# Initialize MariaDB data directory
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql

	echo "Starting temporary MariaDB server for configuration..."
	mysqld_safe --skip-networking &
	sleep 5
