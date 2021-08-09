SHELL:=/bin/bash
REPO := gke-dev-cluster
MIGRATIONS="app/flask/migrations"


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
