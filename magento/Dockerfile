FROM nginx:stable-alpine

MAINTAINER digitalpulp

WORKDIR /var/www

# Ensure www-data user exists.
RUN addgroup -g 82 -S www-data \
  && adduser -u 82 -D -S -G www-data www-data \
  && apk add --no-cache openssl

EXPOSE 443

COPY nginx.conf /etc/nginx/nginx.conf
COPY magento.conf /etc/nginx/conf.d/default.conf

ENV DOCROOT="/var/www/html" \
  SERVER_NAME="_"

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
