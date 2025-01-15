#!/bin/sh

# Set the correct working directory
cd /var/www/wordpress

# Check if wp-config.php exists, if not create it by copying wp-config-sample.php
if [ ! -f "wp-config.php" ] && [ -f "wp-config-sample.php" ]; then
    cp wp-config-sample.php wp-config.php
    echo "Created wp-config.php from wp-config-sample.php."
elif [ ! -f "wp-config-sample.php" ]; then
    echo "Error: wp-config-sample.php is missing."
    exit 1
fi

echo ${DB_NAME}
echo ${DB_USER}
echo ${DB_PASSWORD}
echo ${DB_ROOT_PASSWORD}

# Replace database credentials in wp-config.php
sed -i "s|'DB_NAME', '.*'|'DB_NAME', '${DB_NAME}'|g" wp-config.php
sed -i "s|'DB_USER', '.*'|'DB_USER', '${DB_USER}'|g" wp-config.php
sed -i "s|'DB_PASSWORD', '.*'|'DB_PASSWORD', '${DB_PASSWORD}'|g" wp-config.php
sed -i "s|'DB_HOST', '.*'|'DB_HOST', '${DB_HOST}'|g" wp-config.php
echo "Updated wp-config.php with database credentials."

# Download and configure wp-cli
if [ ! -f "wp-cli.phar" ]; then
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
fi

# Check if WordPress is already installed
if ! php82 wp-cli.phar core is-installed; then
    echo "Installing WordPress..."
    php82 wp-cli.phar core install \
        --url="${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"
else
    echo "WordPress is already installed."
fi

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
/usr/sbin/php-fpm82 -F
