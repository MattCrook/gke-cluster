#!/bin/bash

cd app/flask
# source flaskvenv/bin/activate
pipenv install

if [[ -d "migrations" ]]; then
    echo "Found migrations folder..."
    echo "Starting app..."
else
    echo "No migrations found, running migrations..."
    pipenv run flask init db
    pipenv run flask db migrate -m "Initial migration."
    pipenv run flask db upgrade
fi

export FLASK_ENV=development
export FLASK_APP=app

pipenv run flask run
