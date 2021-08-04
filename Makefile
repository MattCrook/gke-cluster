SHELL:= /bin/bash
REPO := gke-dev-cluster


get_all_resources_in_cluster:
	@chmod +x ./scripts/get_all_resources.sh && ./scripts/get_all_resources.sh

run_flask_app:
	echo "Preparing and running Flask App..."
	sleep 2
	cd app/flask && source flaskenv/bin/activate && FLASK_ENV=development && FLASK_APP=app.py && $(MAKE) prep_requirements && $(MAKE) init_db $$ flask run

kubernetes_dashboard:
	@chmod +x ./scripts/kubernetes_dashboard.sh && ./scripts/kubernetes_dashboard.sh
