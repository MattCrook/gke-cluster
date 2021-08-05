SHELL:= /bin/bash

hard_reset_db:
	@echo "Deleting Migrations folder"
	rm -rf migrations/
	@sleep 3
	@echo "deleting database"
	rm db.sqlite3
	@echo "done"

init_db:
	flask db init
	flask db migrate -m "Initial migration."
	flask db upgrade

make initial_seed:
	curl http://localhost:5000/api/users -X POST -H "Content-Type: application/json" -d '{"name": "Test User", "username": "Test123", "favorite_tech": "Kubernetes", "description": "Container orchestration tool."}'

prep:
	pipenv install --dev

start_venv:
	source flaskenv/bin/activate

prep_req:
	pip install -r requirements.txt
