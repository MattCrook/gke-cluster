SHELL:= /bin/bash
DOCKERHUB_REPO := mgcrook11/flask-app-api

prep:
	pipenv install --dev

start_venv:
	source flaskenv/bin/activate

prep_req:
	pip install -r requirements.txt

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

docker_tag:
	docker tag flask_app_and_api:latest $(DOCKERHUB_REPO):$(tag)

docker_push:
	docker push $(DOCKERHUB_REPO):$(tag)

# Alternatively both commands together for more ease
dockerhub: docker_tag
	docker push $(DOCKERHUB_REPO):$(tag)
