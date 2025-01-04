# Nginx image with alpine base image (Penultimate version)
FROM alpine:3.20

# Install necessary packages: MariaDB and its client
RUN apk update && apk add --no-cache mariadb mariadb-client

# Make necessary directories and set permissions for MariaDB
RUN mkdir -p /var/lib/mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Copy initialization script into the container
COPY ./tools/mariadb_init.sh /tmp/mariadb_init.sh

# Make the script executable
RUN chmod +x /tmp/mariadb_init.sh

# Expose MariaDB default port
EXPOSE 3306

# Start MariaDB using the initialization script (default command)
ENTRYPOINT ["/tmp/mariadb_init.sh"]
