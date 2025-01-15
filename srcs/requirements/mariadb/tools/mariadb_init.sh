#!/bin/sh


echo ${DB_NAME}
echo ${DB_USER}
echo ${DB_PASSWORD}
echo ${DB_ROOT_PASSWORD}

# Initialize MariaDB database if it doesn't already exist
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    mariadbd --user=mysql --bootstrap --console <<-EOSQL
USE mysql;
CREATE DATABASE wordpress;
CREATE USER 'my_user'@'%' IDENTIFIED BY 'my_password';
GRANT ALL PRIVILEGES ON *.* TO 'my_user'@'%';
FLUSH PRIVILEGES;
EOSQL
else
    mariadbd --user=mysql --console
fi
