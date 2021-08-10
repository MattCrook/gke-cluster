SHELL:=/bin/bash
REPO := gke-dev-cluster
MIGRATIONS="app/flask/migrations"


help:
	@echo "    Make targets for developer tooling and applications"
	@echo "        get_all_resources_in_cluster     Get all resources and artifacts in cluster and output into CSV file in resources directory."
	@echo "        kubernetes_dashboard             Run and open the kubernetes dashboard to see metrics on your cluster."
	@echo "    Apps"
	@echo "        run_flask_app_local              Run the flask-app-and-api app locally."
	@echo "        run_flask_app_development        Run the flask-app-and-api app locally in Docker container."
	@echo "        run_node_app_local               Run the node-app locally."
	@echo "        run_node_app_development         Run the node-app locally in Docker container using docker-compose."
	@echo "        run_django_app_local             Run the django-app locally."
	@echo "        run_django_app_development       Run the django-app locally in Docker container using docker-compose."
	@echo "        docker_tag                       Tag the specifed image. Usually in prep to push to DockerHub. Args: image=<image_to_tag> tag=<desired_tag> DOCKERHUB_REPO=<dockerhub_repo_to_push_to>"
	@echo "        docker_push                      Push image to Dockerhub. Args: tag=<TAG> DOCKERHUB_REPO=<REPO>"
	@echo "        dockerhub                        Tag and Push image to Dockerhub in one command. Args: image=<image_to_tag> tag=<TAG> DOCKERHUB_REPO=<REPO>"


get_all_resources_in_cluster:
	@chmod +x ./scripts/get_all_resources.sh && ./scripts/get_all_resources.sh

run_flask_app_local:
	@echo "Preparing and running Flask App..."
	@sleep 2
	# @chmod +x ./scripts/create_venv.sh && ./scripts/create_venv.sh
	@chmod +x ./scripts/run_flask_app_local.sh && ./scripts/run_flask_app_local.sh

run_flask_app_development:
	@echo "Preparing and running Flask App..."
	@sleep 2
	@chmod +x ./scripts/create_venv.sh && ./scripts/create_venv.sh
	@if [ -d $(MIGRATIONS) ]; then \
		$(MAKE) hard_reset_db && \
		app/flask/docker build -t flask-app-api . && \
		docker run -it -d -p 5000:5000 flask-app-api; \
	else \
		app/flask/docker build -t flask-app-api . && \
		docker run -it -d -p 5000:5000 flask-app-api; \
	fi

kubernetes_dashboard:
	@chmod +x ./scripts/kubernetes_dashboard.sh && ./scripts/kubernetes_dashboard.sh

run_node_app_local:
	@echo "Preparing and running Node.js/ Express App..."
	@sleep 2
	@chmod +x ./scripts/run_node_app_local.sh && ./scripts/run_node_app_local.sh

run_node_app_development:
	@echo "Preparing and running Node.js/ Express App..."
	@sleep 2
	cd app/node/ && docker-compose up --build

run_django_app_local:
	@echo "Preparing and running Django App..."
	@sleep 2
	@chmod +x ./scripts/run_django_app_local.sh && ./scripts/run_django_app_local.sh

run_django_app_development:
	@echo "Preparing and running Django App..."
	@sleep 2
	cd app/django/ && docker-compose up --build

docker_tag:
	docker tag $(image):latest $(DOCKERHUB_REPO):$(tag)

docker_push:
	docker push $(DOCKERHUB_REPO):$(tag)

# Alternatively both commands together for more ease
dockerhub: docker_tag
	docker push $(DOCKERHUB_REPO):$(tag)
