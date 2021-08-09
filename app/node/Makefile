SHELL:=/bin/bash
DOCKERHUB_REPO := mgcrook11/gke-node-app

prep:
	npm install

make run_local:
	npm run dev

make run_docker:
	docker build -t gke-node-app .
	docker run -it -d -p 8080:8080 gke-node-app


make run_docker_compose_up:
	docker-compose up --build

make docker_exec:
	# ToDo: Grab latest sha and automaically put it in as arg so user doesn't have to
	docker exec -it $(CONTAINER_ID) /bin/sh

docker_tag:
	docker tag flask_app_and_api:latest $(DOCKERHUB_REPO):$(tag)

docker_push:
	docker push $(DOCKERHUB_REPO):$(tag)

# Alternatively both commands together for more ease
dockerhub: docker_tag
	docker push $(DOCKERHUB_REPO):$(tag)
