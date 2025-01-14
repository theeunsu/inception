#!/bin/sh

# Check if wp-config.php exists, if not create it by copying wp-config-sample.php
if [ ! -f "wp-config.php" ]; then 
    mv wp-config-sample.php wp-config.php
fi

# Replace database credentials in wp-config.php
sed -i "s|define( 'DB_NAME', 'database_name_here' );|define( 'DB_NAME', '${DB_NAME}' );|g" wp-config.php && \
sed -i "s|define( 'DB_USER', 'username_here' );|define( 'DB_USER', '${DB_USER}' );|g" wp-config.php && \
sed -i "s|define( 'DB_PASSWORD', 'password_here' );|define( 'DB_PASSWORD', '${DB_PASSWORD}' );|g" wp-config.php && \
sed -i "s|define( 'DB_HOST', 'localhost' );|define( 'DB_HOST', '${DB_HOST}' );|g" wp-config.php

# Download and configure wp-cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# Install WordPress core
php82 wp-cli.phar core install \
    --url="${DOMAIN_NAME}" \
    --title="Inception" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}"

# Start PHP-FPM in the foreground
/usr/sbin/php-fpm82 -F
