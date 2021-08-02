# Google Kubernetes Engine

This repo houses a collection of modules I have created for provisioning various GCP resources, mainly a fully customized GKE cluster, as well as three different environments to deploy them to; dev, staging, and prod.

##### *Currently work in progress*

## Modules

The modules directory houses all the parent modules from which to use, these include:
 * Cloud NAT
 * CloudSpanner
 * CloudSQL
 * A CloudSQL Failover
 * GKE Cluster (with additional Managed Nodes)
 * Firewall
 * Internal TCP LoadBalancer
 * External HTTP LoadBalancer
 * Subnetwork
 * VPC
 * Google Compute Engine (GCE)
   * Autoscaling Instance Group
   * Compute Router Instances
   * Basic Single Compute Instance
   * Instance Group
   * A NAT Instance
   * Google Compute Network (VPC)

## Global

Houses infrastructure for creating Google Storage Buckets, with corresponding IAM permissions, to store the Terraform State File, if you wish to use a remote backend.

## App

This directory houses small apps I have made to containerize (with Docker) and deploy/ run on the GCP infrastructure created in Terraform. See the ReadMe in the App directory for more...

## Live

Houses the different environments to deploy to. Currently set up for:

* `dev`
* `staging`
* `prod`

## Scripts

Ad hoc scripts for developer tooling. Most scripts are not required and do not need to be run directly. They can be run from the Makefile in the root of this project. Description of the scripts below:

* `make get_all_resources_in_cluster` - Once you have a GKE cluster up and running, this command will run a form of `kubectl api-resources` on your cluster, and output the results into a `resources` directory, with each resource separated into it's own CSV file with its containing artifacts. 
  * This is a great way to see ***exactly*** everything that is running in your cluster, without having to run a form of  `kubectl get all`, then running a `kubectl get` on each individual resource that would not be returned with a `get all` call.
