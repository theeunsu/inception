#!/bin/sh


echo ${DB_NAME}
echo ${DB_USER}
echo ${DB_PASSWORD}
echo ${DB_ROOT_PASSWORD}

# Initialize MariaDB database if it doesn't already exist
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    echo "Initializing MariaDB database..."
    
    # Run MariaDB bootstrap process to set up the initial database and users
    mariadbd --user=mysql --bootstrap --console <<-EOSQL
        USE mysql;

        CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;

        CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';

        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';

        FLUSH PRIVILEGES;
EOSQL
else
    echo "MariaDB database directory already exists. Skipping initialization..."
fi

# Start MariaDB in foreground mode
echo "Starting MariaDB server..."
exec mariadbd --user=mysql --console