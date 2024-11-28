#!/bin/bash

cd /usr/src/app

if [ ! -f ".env" ]; then
  cp .env.example .env
fi

set -e
dockerize -wait tcp://database:5432 -wait tcp://rabbitmq:5672 -timeout 30s
exec "$@"

python manage.py makemigrations
python manage.py migrate
python manage.py loaddata fake_data 
python manage.py loaddata initial_data 
python manage.py runserver 0.0.0.0:8000

exec gunicorn --bind 0.0.0.0:8000 config.wsgi:application