#!/bin/bash

cd /usr/src/app

# Ensure .env file exists, if not, copy it from .env.example
if [ ! -f ".env" ]; then
  cp .env.example .env
fi

# Wait for the database and RabbitMQ to be available
dockerize -wait tcp://database:5432 -wait tcp://rabbitmq:5672 -timeout 2700s -wait-retry-interval 10s

# Apply migrations
python manage.py makemigrations
python manage.py migrate

# Load initial and fake data into the database
python manage.py loaddata fake_data
python manage.py loaddata initial_data

# Collect static files before starting the server
python manage.py collectstatic --noinput

# Run Gunicorn server instead of Django's development server
gunicorn --bind 0.0.0.0:8000 config.wsgi:application

# Uncomment this line if you need a background worker (e.g., for Celery)
# celery -A your_project_name worker --loglevel=info
