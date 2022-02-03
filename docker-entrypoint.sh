#!/bin/bash

# fcgiwrap
/etc/init.d/fcgiwrap start

# nginx
ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log

sed -i 's/# server_tokens/server_tokens/g' /etc/nginx/nginx.conf

if [[ -n "$PORT" ]]; then
  sed -i "s/listen \([0-9]\+\)/listen $PORT/g" /etc/nginx/sites-enabled/default
else
  PORT=80
fi

echo " * Listening to port $PORT."

nginx -g 'daemon off;'
