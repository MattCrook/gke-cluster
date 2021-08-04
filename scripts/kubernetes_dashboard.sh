#!/bin/bash

# echo "Copying the contents of you .kubeconfig to your clipboard."
# cat ~/.kube/config > /dev/clip
echo "Your .kubeconfig file is located at ~/.kube/config"

# TOKEN=$(cat ~/.kube/config)
sleep 4
open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

echo "Proxying to the Kubernetes Dashboard"
kubectl proxy
