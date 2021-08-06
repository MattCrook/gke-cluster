# GKE Cluster

This directory is a child module, or in other words, *uses* the module located at `gke/modules/cluster`.

If you wish to provision a Kubernetes cluster, there are two options:

1) Use the provided Terraform to provision the cluster
2) If you don't need such robust customization, or want to spin up a cluster quickly for demo or testing purposes, you can use the glcoud CLI tool.


## Setup basic cluster with gcloud

As a shortcut, you can choose to not use Terraform and spin up a GKE cluster with the gcloud CLI tool:

```
gcloud container clusters create <CLUSTER_NAME> \
    --num-nodes=2 \
    --project=<PROJECT_NAME> \
    --zone=<ZONE> \
    --machine-type e2-medium \
    --enable-stackdriver-kubernetes
```
* Where:
  *  `<CLUSTER_NAME>` is the name you choose to give the cluster.
  *  `<PROJECT_NAME` is the name of your project you want to put the cluster in - as shown in the GCP console. (Top left, to the right of *Google Cloud Platform*).
  *  `<ZONE>` is the zone you want the cluster to reside in.
     *  For example, `us-central1-c`.
     *  Setting zone will create a zonal cluster, however you can replace this with a region which will create a regional cluster.
        *  For more info on zonal vs regional, refer to the [GCP docs](https://cloud.google.com/kubernetes-engine/docs/concepts/types-of-clusters).

## Setup Cluster with Terraform

To provision cluster with Terraform, cd into the `gke/live/dev/cluster` directory.

**Note** - Some customization might be needed, such as changing the variables for `project` and `primary_zone` to reflect your desired values. Right now, since this is for demo purposes, the cluster is also using the default VPC and corresponding subnetworks, though the capability is there should you want to create your own. The cluster also has minimum permissions surrounding it, you as the creator are given the cluster admin role.

When ready to spin up the cluster, run:

* `terraform init`
* `terraform plan`
* `terraform apply`

Be advised, it may take up to ten to fifteen minutes for the cluster to finish provisioning.

Once it is done, you can connect to it to create a context locally for Kubernetes and Helm and by running:

* `gcloud container clusters get-credentials <CLUSTER_NAME> --zone <ZONE>`
  * Or in the GCP console click the three dots and select "connect", and copy and paste that blurb of code into your terminal.
