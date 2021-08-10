SHELL:=/bin/bash
DOCKERHUB_REPO := mgcrook11/gke-node-app


help:
	@echo "    Node App Make Targets"
	@echo "        node_prep                        Install dependencies and dev dependencies."
	@echo "        run_local                        Run app locally."
	@echo "        run_docker                       Run the app locally using Docker."
	@echo "        run_docker_compose_up            Run the app locally using docker-compose."
	@echo "        docker_exec                      Exec into running Docker container - for debug purposes. Args: CONTAINER_ID=<container_to_exec_into_id>"
	@echo "        docker_tag                       Tag the specifed image. Usually in prep to push to DockerHub. Args: tag=<TAG> DOCKERHUB_REPO=<REPO>"
	@echo "        docker_push                      Push image to Dockerhub. Args: tag=<TAG> DOCKERHUB_REPO=<REPO>"
	@echo "        dockerhub                        Tag and Push image to Dockerhub in one command. Args: tag=<TAG> DOCKERHUB_REPO=<REPO>"


node_prep:
	npm install

make run_local:
	npm run dev

make run_docker:
	docker build -t gke-node-app .
	docker run -it -d -p 8080:8080 gke-node-app:latest

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
