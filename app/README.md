# Applications

This directory houses applications you that can be run locally, run in a Docker container, or pulled into your GCP infrastructure (for example such as a GKE cluster, by deploying a pod with the Docker image).


## Golang

***Work in Progress***

#### Setup

cd into the `/app/go/` directory in your terminal and follow the instructions on the ReadMe [here](go/).

Install dependencies from Go module:
```
make prep_go
```


## Django

***Work in Progress***

<!-- ### Setup

* `make prep_django` -->

#### Setup

cd into the `/app/django/` directory in your terminal and follow the instructions on the ReadMe [here](django/).

## Flask

#### Setup

#### Running Locally

If you wish to run the app locally, you can do so by cd into the `/app/flask/` directory in your terminal and follow the instructions on the ReadMe [here](flask/).

#### Provisioning infrastructure and deploying app with Kubernetes or Helm

To see instructions on provisioning the infrastructure, see the ReadMe for the child module cluster [here](/gke/live/dev/cluster/).

To see instructions on deploying with Kubernetes or Helm, see the ReadMe [here](/gke/live/dev/app/).



## Express/ Node.js

#### Setup

If you wish to run the app locally, you can do so by cd into the `/app/node/` directory in your terminal and follow the instructions on the ReadMe [here](node/).


#### Provisioning infrastructure and deploying app with Kubernetes or Helm

To see instructions on provisioning the infrastructure, see the ReadMe for the child module cluster [here](/gke/live/dev/cluster/).

To see instructions on deploying with Kubernetes or Helm, see the ReadMe [here](/gke/live/dev/app/).
