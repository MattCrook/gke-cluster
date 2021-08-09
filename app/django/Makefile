SHELL:=/bin/bash
DOCKERHUB_REPO := mgcrook11/gke-django-app

prep:
	pipenv install
	pipenv sync --dev

hard_reset_db:
	@echo "Deleting Migrations folder"
	rm -rf project/app/migrations/
	@sleep 2
	@echo "deleting database"
	rm project/db.sqlite3
	@echo "done"

init_db:
	cd project && pipenv run python3 manage.py makemigratons
	cd project && pipenv run python3 manage.py migrate

make run_local:
	cd project && python3 manage.py runserver
