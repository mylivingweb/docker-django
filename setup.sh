#!/bin/bash

if [ -z ${DOMAIN} ]; then
    echo "Error - empty domain name!"
    exit 1
fi

sed -i "s/DOMAIN/${DOMAIN}/g" /${DOMAIN}/config/django.ini
sed -i "s/DOMAIN/${DOMAIN}/g" /${DOMAIN}/config/e.config
sed -i "s/DOMAIN/${DOMAIN}/g" /${DOMAIN}/config/nginx.conf
sed -i "s/PROJECT/${PROJECT}/g" /${DOMAIN}/config/django.ini
sed -i "s/PROJECT/${PROJECT}/g" /${DOMAIN}/config/e.config
sed -i "s/PROJECT/${PROJECT}/g" /${DOMAIN}/config/nginx.conf
sed -i "s/PORT/${PORT}/g" /${DOMAIN}/config/nginx.conf

# setup place for our uwsgi socket
mkdir /${DOMAIN}/run/
chown djangouser:nginx /${DOMAIN}/run/
chmod 775 /${DOMAIN}/run/

# start first django project

# set perms
chown -R djangouser:nginx /${DOMAIN}/config

echo "Your project's code is located in: /${DOMAIN}/config/${PROJECT}/" 

# save used domainname 
echo "${DOMAIN}" > /.django
echo "${PROJECT}" > /.project
