#!/bin/bash

cd /usr/src/app
./docker/wait-for-it.sh app 8000 -- celery -A config.celery worker -B -l info -s /tmp/celerybeat-schedule

dockerize -wait tcp://database:5432 -wait tcp://app:8000 -timeout 2700s -wait-retry-interval 10s

celery worker -B -l info -A config.celery -s /tmp/celerybeat-schedule
