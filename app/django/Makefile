SHELL:=/bin/bash
DOCKERHUB_REPO := mgcrook11/gke-django-app

prep:
	pipenv install
	pipenv sync --dev

hard_reset_db:
	@echo "deleting database"
	rm db.sqlite3
	@echo "done"

init_db:
	pipenv run python3 manage.py makemigratons
	pipenv run python3 manage.py migrate

make run_local:
	pipenv run python3 manage.py runserver

make run docker:
	docker build -t gke-django-app .
	docker run -it -d -p 8000:8000 --env-file .env gke-django-app:latest

make run_docker_compose_up:
	docker compose up --build
