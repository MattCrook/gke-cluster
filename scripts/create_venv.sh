#!/bin/bash

DIR="app/flask/flaskvenv"

if [ -d $DIR ]; then
    echo "Found existing virtualenv"
    sleep 2
else
    echo "No virtual env found...creating flaskvenv"
    cd app/flask
    python3 -m flaskvenv venv
    cd -
fi
