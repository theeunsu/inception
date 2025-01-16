# Use a lightweight and secure base image
FROM alpine:3.20

# Install necessary packages
RUN apk update && apk upgrade \
&& apk add --no-cache nginx openssl

# Copy initialization script and configuration files
COPY ./tools/nginx_init.sh /tmp/nginx_init.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/conf.d/default.conf /etc/nginx/conf.d/default.conf

# Change permissions of the script
RUN chmod +x /tmp/nginx_init.sh

# Expose HTTPS port
EXPOSE 443

# Set the container's entry point
CMD ["/tmp/nginx_init.sh"]
