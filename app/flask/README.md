# Flask App and API

Basic Flask app with an API and runs an in memory database, and runs in a Docker container for demo purposes. Instructions on how to deploy the app to a Kubernetes cluster are below.

![flask-app-api-1](/app/public/Flask-app-api-1.png)
![flask-app-api-1](/app/public/Flask-app-api-2.png)


## Setup

Run the following Make targets if you wish to run the app either locally, or using Docker.

#### Running Locally

If you want to use pipenv to manage your virtualenv, to install dependencies and create virtual environment:
```
make prep
```

If you choose to use the old fashioned way to manage your venv, to install dependencies and create virtual environment:

```
python3 -m flaskvenv venv
make start_venv`
make prep_req`
```

The application will need migrations to be run before you can start it, to do so, be in the flask directory and run:
```
make init_db
```

Now you can run the application, to do so, be in the flask directory and run:
```
make run_local
```

The app will be available on `http://localhost:5000`

#### Running with Docker (preferred)

To run app using Docker, cd into the `app/flask/` directory and run:

```
docker build -t flask_app_api .
docker run -it -d -p 5000:5000 flask_app_api
```

With the image built and the container running, the app should now be available on `http://localhost:5000`


## Provisioning infrastructure and deploying app with Kubernetes or Helm

The app can be run on any infrastructure you choose (single compute instance, instance group, GKE cluster etc...) but for this example, it is meant to run in a GKE cluster.

***To see instructions on provisioning the infrastructure, see the ReadMe for the child module cluster [here](/gke/live/dev/cluster/).***

***To see instructions on deploying with Kubernetes or Helm, see the ReadMe [here](/gke/live/dev/app/).***


| NOTE: This is pulling a private Docker repository image. Either change the image in the `.yaml` file to one of yours, and deploy a docker registry secret, or change the image to a public image. |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

* Public image for this app is `mgcrook11/flask-app-api-public:1.0`
* Change the `.spec.containers.image` to this and get rid of `imagePullSecrets`

#### Tearing Down

Don't forget to clean up your infrastructure once finished.

If created cluster with glcoud, run:
```
gcloud container clusters delete <CLUSTER_NAME>
```

If created with Terraform, run:
```
terraform destroy
```
