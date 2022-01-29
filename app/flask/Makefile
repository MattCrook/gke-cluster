SHELL:=/bin/bash
DOCKERHUB_REPO := mgcrook11/flask-app-api

help:
	@echo "    Flask App and API Make Targets"
	@echo "        flask_prep                       Create virtualenv (if not one), install dependencies and dev dependencies, and lock Pipfile.lock."
	@echo "        start_venv                       Activate virtualenv (the old fashioned way)."
	@echo "        prep_req                         Install dependencies from requirements.txt file."
	@echo "        hard_reset_db                    Completely reset DB. Will delete all migrations in migrations folder and DB."
	@echo "        init_db                          Update and sync DB by running migrations."
	@echo "        initial_seed                     Initaial POST to seed the DB with dummy data."
	@echo "        run_local                        Run app locally."
	@echo "        run_docker                       Run the app locally using Docker."
	@echo "        docker_tag                       Tag the specifed image. Usually in prep to push to DockerHub. Args: tag=<TAG> DOCKERHUB_REPO=<REPO>"
	@echo "        docker_push                      Push image to Dockerhub. Args: tag=<TAG> DOCKERHUB_REPO=<REPO>"
	@echo "        dockerhub                        Tag and Push image to Dockerhub in one command. Args: tag=<TAG> DOCKERHUB_REPO=<REPO>"


flask_prep:
	pipenv install
	pipenv sync --dev

start_venv:
	source flaskvenv/bin/activate

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

make run_local:
	export FLASK_APP=app
	export FLASK_ENV=development
	flask run

make run_docker:
	docker build -t flask-app-api .
	docker run -it -d -p 5000:5000 flask-app-api:latest

docker_tag:
	docker tag flask-app-api:latest $(DOCKERHUB_REPO):$(tag)

docker_push:
	docker push $(DOCKERHUB_REPO):$(tag)

# Alternatively both commands together for more ease
dockerhub: docker_tag
	docker push $(DOCKERHUB_REPO):$(tag)
