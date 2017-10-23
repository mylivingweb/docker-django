#!/bin/bash
DOMAIN=`cat /.django` 
PROJECT=`cat /.project`

cd /${DOMAIN}/config/${PROJECT}
pip3.5 install -r /${DOMAIN}/config/${PROJECT}/requirements.txt

python3.5 /${DOMAIN}/config/${PROJECT}/manage.py collectstatic --noinput
python3.5 /${DOMAIN}/config/${PROJECT}/manage.py makemigrations
python3.5 /${DOMAIN}/config/${PROJECT}/manage.py migrate

chown -R djangouser:nginx /${DOMAIN}/config

export LC_ALL=en_US.utf8

# run uwsgi in background
uwsgi --ini /${DOMAIN}/config/django.ini --uid 9999 --gid 9999 &

# start nginx
exec nginx
