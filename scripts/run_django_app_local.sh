#!/bin/bash

cd app/django
pipenv install
pipenv sync --dev
python3 manage.py runserver
