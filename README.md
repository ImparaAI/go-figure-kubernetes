Kubernetes configuration for running the go figure environment.

# Setup

1. Have access to [`kubectl`](https://kubernetes.io/docs/setup/pick-right-solution/) and [`helm`](https://github.com/helm/helm#install) from your command line
2. If you're running locally (rather than in gcloud, for example), ensure you have docker installed (and possibly minikube depending on your version of docker)
3. Run `helm init` if you haven't installed Tiller on your cluster yet
4. Copy `values.example.yaml` to `values.yaml` and fill in *all* the values for your environment
5. Ensure you have the domain you specified in your system's hosts file pointing at 127.0.0.1
6. Run `helm dependency build` and `helm install .` from the root of this repo
7. After a few moments, the app should be running at your domain

# Running in gcloud

If you already have gcloud on your system and have no problem switching kubeconfigs locally, you should just be able to follow the above instructions and deploy to a GKE cluster. However, if you aren't familiar with gcloud roles and

If you want a slightly more isolated approach, you can head to the `/kubectl` directory where you have access to a container that has kubectl and gcloud already installed.

1. Mount the local path to this repo in a `docker-compose.override.yaml` file.
2. Run `docker-compose up -d` from that directory
3. Run `docker exec -it kubectl bash` to get into the container
4. Head over to `cd /var/kube`

If you've already set up your gcloud values.yaml, you can run `./gcloud_install` from the root. Otherwise if you want to do it manually and get stuck, that file is a good place to start figuring out what is needed to get it all running.

## Setting up your cluster with an Nvidia GPU

Modify the `values.yaml` file to set `prediction.nvidia_gpu` to `true`. Make

If you're running `./gcloud_install`, that script will install the drivers for you. Otherwise, you should make sure you follow the [Kubernetes instructions for scheduling GPUs](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus) to ensure the prediction container has access to the correct drivers and node pools.