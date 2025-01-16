#!/bin/sh

echo ${DOMAIN_NAME}
echo ${DB_NAME}
echo ${DB_USER}
echo ${DB_PASSWORD}
echo ${DB_ROOT_PASSWORD}
echo ${DB_HOST}
echo ${WP_ADMIN_USER}
echo ${WP_ADMIN_PASSWORD}
echo ${WP_ADMIN_EMAIL}


# Create database and user, set a password, change root password, grant privileges
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	mariadbd --user=mysql --bootstrap --console <<EOSQL
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE ${DB_NAME};
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOSQL
else
	mariadbd --user=mysql --console
fi
