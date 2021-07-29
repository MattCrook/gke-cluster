SHELL:=/bin/bash
REPO := gke-dev-cluster


get_all_resources_in_cluster:
	@chmod +x ./scripts/get_all_resources.sh && ./scripts/get_all_resources.sh

run_app:
	# cd into app dir and run command to start app locally
