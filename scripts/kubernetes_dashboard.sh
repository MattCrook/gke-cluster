#!/bin/sh

KUBERNETES_DASHBOARD_URL=http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

echo "Proxying to the Kubernetes Dashboard"
kubectl proxy

echo "Copying the contents of you .kubeconfig to your clipboard."
cat ~/.kube/config > /dev/clip
sleep 4
open http://$KUBERNETES_DASHBOARD_URL
