#!/bin/bash
if [ ! -f /etc/nginx/certs/localhost.crt ] || [ ! -f /etc/nginx/certs/localhost.key ]; then
    echo "Error: SSL certificates are missing"
    exit 1
fi
crond
exec nginx -g "daemon off;"
chmod +x /entrypoint.sh
echo "Done nginx"
