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
