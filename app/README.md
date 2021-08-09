# Applications

This directory houses applications you that can be run locally, run in a Docker container, or pulled into your GCP infrastructure (for example such as a GKE cluster, by deploying a pod with the Docker image).

#### Provisioning infrastructure and deploying app with Kubernetes or Helm

If you do not wish to, or don't care to run the applications locally for yourself and want to skip ahead to deploying the infrastructure:
* To see instructions on provisioning the infrastructure, see the ReadMe for the child module cluster [here](/gke/live/dev/cluster/)
* To see instructions on deploying with Kubernetes or Helm, see the ReadMe [here](/gke/live/dev/app/).

## Golang

***Work in Progress***

### Setup

#### Running Locally


To run the app locally or with Docker, `cd` into the `/app/go/` directory in your terminal and follow the instructions on the ReadMe [here](go/).

Install dependencies from Go module:
```
make prep_go
```


## Django

***Work in Progress***
### Setup

#### Running Locally


`cd` into the `/app/django/` directory in your terminal and follow the instructions on the ReadMe [here](django/).

## Flask

### Setup

#### Running Locally

If you wish to run the app locally or with Docker, you can do so by `cd` into the `/app/flask/` directory in your terminal and follow the instructions on the ReadMe [here](flask/).

## Express/ Node.js

### Setup

#### Running Locally

If you wish to run the app locally or with Docker, you can do so by cd into the `/app/node/` directory in your terminal and follow the instructions on the ReadMe [here](node/).
