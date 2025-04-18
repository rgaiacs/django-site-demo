#!/bin/sh
#
# Docker entrypoint for the development environment.

# Stop on first return of a non-zero status
# https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#The-Set-Builtin
set -e

DJANGO_APP_DEMO_DIR=/mnt/django-app-demo
if [ -f $DJANGO_APP_DEMO_DIR/pyproject.toml ]
then
    echo Development version of django-app-demo located in $DJANGO_APP_DEMO_DIR
    python3 -m pip install \
    --editable \
    $DJANGO_APP_DEMO_DIR
fi

# Environment variables used to create Django super user.
# https://docs.djangoproject.com/en/5.1/ref/django-admin/#createsuperuser
export DJANGO_SUPERUSER_USERNAME=admin
export DJANGO_SUPERUSER_EMAIL=root@localhost
export DJANGO_SUPERUSER_PASSWORD=123

# Run database migration
# This need to be first to avoid errors due missing tables
python3 manage.py migrate \
    --no-input \
    --traceback

# Remove all existing data
python3 manage.py flush \
    --no-input \
    --traceback

# Create Django super user
# This need to be after load the fixtures
# for the super user to have the correct password.
createsuperuser.sh

# Start Django development server
python3 manage.py runserver \
    0.0.0.0:8000
