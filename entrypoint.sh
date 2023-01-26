#!/bin/sh

# # start fastcgi_wrap
echo "Starting fcgiwrap..."
/usr/bin/spawn-fcgi -p 9000 /usr/sbin/fcgiwrap &

# # start nginx
echo "Starting nginx..."
nginx -g 'daemon off;'
