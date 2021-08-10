SHELL:=/bin/bash
DOCKERHUB_REPO := mgcrook11/gke-django-app

help:
	@echo "    Django App Make Targets"
	@echo "        django_prep                      Create virtualenv (if not one), install dependencies and dev dependencies, and lock Pipfile.lock."
	@echo "        hard_reset_db                    Completely reset DB. Will delete the DB."
	@echo "        init_db                          Update and sync DB by running migrations."
	@echo "        run_local                        Run app locally."
	@echo "        run_docker                       Run the app locally using Docker."
	@echo "        run_docker_compose_up            Run the app locally using docker-compose."


django_prep:
	pipenv install
	pipenv sync --dev

hard_reset_db::
	@echo "deleting database"
	rm db.sqlite3
	@echo "done"

init_db::
	pipenv run python3 manage.py makemigratons
	pipenv run python3 manage.py migrate

make run_local::
	pipenv run python3 manage.py runserver

make run_docker::
	docker build -t gke-django-app .
	docker run -it -d -p 8000:8000 --env-file .env gke-django-app:latest

make run_docker_compose_up::
	docker compose up --build
