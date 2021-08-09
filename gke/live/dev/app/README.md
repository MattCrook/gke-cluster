# Container Orchestration With Kubernetes and Helm

This directory houses all of the manifests for deploying the various apps to GKE. You can use the Kubernetes config files themselves, or use the Kubernetes package manager Helm.


## Using Kubernetes

cd into the `gke/live/dev/app/Kubernetes` directory in your terminal.

Deploy a LoadBalancer that will expose an external IP:
```
kubectl apply -f loadbalancer.yaml
```

Deploy a deployment that will manage the pods:
```
kubectl apply -f deployment.yaml
```

***NOTE*** - Again, this is pulling a private Docker repository image. Either change the image in the `.yaml` file to one of yours, and deploy a docker registry secret, or change the image to a public image.
* Change the `.spec.containers.image` to this and get rid of `imagePullSecrets`

As a bonus, you can install the Kubernetes Dashboard for visualizing metrics and monitoring:
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
```
* To access, run:
  * `kubectl proxy`
    * Then open up:
      *  `http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy`
      *  Select *from config* and the config file should be located at `~/.kube/config`

## Using Helm

cd into the `gke/live/dev/app/helm/flask-app-api` directory in your terminal.

***NOTE*** - Same warning as previously mentioned, the deployment is pulling a private docker image, follow the instructions mentioned previously.

To deploy the chart as a Release:
Do a dry run first, and run with the debug flag:
```
helm install <CHART-NAME> -n <NAMESPACE> --values values.yaml --debug --dry-run .
```

If the output looks good and like what you expect:
```
helm install <CHART-NAME> -n <NAMESPACE> --values values.yaml --debug .
```

If you make changes to the manifests, and need to upgrade the Release:

```
helm upgrade <RELEASE_NAME> --install -n <NAMESPACE> --values values.yaml -n default --debug --dry-run .

helm upgrade <RELEASE_NAME> --install -n <NAMESPACE> --values values.yaml -n default --debug .
```

To Uninstall a Release:

```
helm uninstall <Release> --dry-run --debug
helm uninstall <Release>
```

##### If you choose to use an Ingress instead of LoadBalancer, you will also need to install and deploy an Ingress Controller to use an Ingress. You can make use of the Nginx Ingress Controller:

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/cloud/deploy.yaml
```
##### To confirm the Ingress Controller was created, and configured to your cluster; to get the External IP of the Ingress you can run:

```
kubectl get ingress -n default
```

##### Then to view app, if configured correctly, it should be available at:

```
Then, in your browser:
- http://<INGRESS_IP>:<PORT>
```

## Tearing Down

If created cluster with glcoud, run:
```
gcloud container clusters delete <CLUSTER_NAME>
```

If created with Terraform, run:

```
terraform destroy
```
