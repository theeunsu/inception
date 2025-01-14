#!/bin/sh

# Initialize MariaDB database if it doesn't already exist
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    echo "Initializing MariaDB database..."
    
    # Run MariaDB bootstrap process to set up the initial database and users
    mariadbd --user=mysql --bootstrap --console <<-EOSQL
        USE mysql;

        -- Create the WordPress database
        CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;

        -- Create the WordPress user and grant privileges
        CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';

        -- Update root user password for localhost
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';

        -- Apply changes
        FLUSH PRIVILEGES;
EOSQL
else
    echo "MariaDB database directory already exists. Skipping initialization..."
fi

# Start MariaDB in foreground mode
echo "Starting MariaDB server..."
exec mariadbd --user=mysql --console
