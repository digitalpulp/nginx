#!/bin/sh
set -e

# Configure docroot.
sed -i 's@%DOCROOT%@'"${DOCROOT}"'@' /etc/nginx/conf.d/*.conf
echo "Configured docroot to ${DOCROOT}."

# Set server name.
sed -i 's/%SERVER_NAME%/'"${SERVER_NAME}"'/' /etc/nginx/conf.d/*.conf
echo "Configured server name to ${SERVER_NAME}."

# Generate a cert for local use.
openssl genrsa -out /etc/nginx/certs/${VIRTUAL_HOST}.key 2048
openssl req -new -key /etc/nginx/certs/${VIRTUAL_HOST}.key -out /etc/nginx/certs/${VIRTUAL_HOST}.csr -subj "/C=US/ST=New York/L=New York/O=Digital Pulp/OU=Engineering/CN=${VIRTUAL_HOST}"
openssl x509 -req -days 365 -in /etc/nginx/certs/${VIRTUAL_HOST}.csr -signkey /etc/nginx/certs/${VIRTUAL_HOST}.key -out /etc/nginx/certs/${VIRTUAL_HOST}.crt


exec "$@"
