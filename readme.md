# Terraform cluster provisioning for Athenaeum
We provision athenaeum clusters with terraform. These are GKE base cluster and helm tiller will be installed. This will also automatically update kubectl configuration.
### Set up
Once this repo is downloaded, as usual, you will need to run cd to the appropriate entrypoint directory and run `terraform init` to download plugins etc. You will need to get the credentials for (and possibly set create) the service account that `terraform` uses to execute tasks on GCP. This is describe in the [terraform reference](https://www.terraform.io/docs/providers/google/index.html) for the google provider and you can go directly to the [gcp console](https://console.cloud.google.com/apis/credentials/serviceaccountkey) to get the key file. The key file belongs in the entry point directory.

The repo has three main entry points:
* root: provisions a basic cluster asking you to fill in basic config variables
* staging: provisions a cluster for staging and is configured by default
* production: provisions a cluster for staging and is configured by default
Even in the default configurations you can always override the input variables to change things like zone, account, initial_node_count etc.

### Requirements
You will need to have both `gcloud`, `kubectl`, and `helm` installed on your local machine. These are required by resource provisioners to set up `kubectl`, provide the apropriate role for cluster control and initialize and secure `helm`.

### Use
Basic use is
- `cd <entrypoint>`
- copy GCP account credentials into the directory.
- `terraform init`
- `terraform plan` 

At this point you should have a description of the resources that `terraform` will create on the GCP. Assuming that all is as expected:
-  `terraform apply`
And you can watch as a cluster is created.

To test the cluster try the following
- `gcloud container clusters list`
You should see your new cluster listed there.
- `kubectl get svc --namespace kube-system`
You should see a service called tiller-deploy there.
- `helm version`
- `helm list`
In the first case you should see the version of tiller and helm client listed. In the second you should see a simple return, but this tells you that helm is doing what it is suposed to. 

At this point you the cluster is ready for action. There still a bit more to be done to get a full athenaeum up and running including: auth0 config, DNS config, athenaeum/jupyterhub installation with helm. 





