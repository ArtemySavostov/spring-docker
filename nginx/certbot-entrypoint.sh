#!/bin/bash
echo 'Start reconfigure NGINX'
set -e
sleep 5
certbot --nginx -d savostov-a.ru -d www.savostov-a.ru --non-interactive --agree-tos --email savostov322@yandex.ru
nginx -s reload
exec "$@"
