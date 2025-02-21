#!/bin/sh


if [ "$PROTOCOL" = "http://" ]
then
    echo "setting nginx config to http"
    rm /etc/nginx/conf.d/app-ssl.conf
    cp /opt/app.conf /etc/nginx/conf.d/app.conf
    sed -i 's/server_name.*/server_name '${DOMAIN}';/' /etc/nginx/conf.d/app.conf

else
    echo "setting nginx config to https"
    rm /etc/nginx/conf.d/app.conf
    cp /opt/app-ssl.conf /etc/nginx/conf.d/app-ssl.conf
    sed -i 's/server_name.*/server_name '${DOMAIN}';/' /etc/nginx/conf.d/app-ssl.conf
fi

nginx -g "daemon off;"
