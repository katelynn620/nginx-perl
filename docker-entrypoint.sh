#!/bin/bash
/etc/init.d/fcgiwrap start

sed -i 's/# server_tokens/server_tokens/g' /etc/nginx/nginx.conf
nginx -g 'daemon off;'
