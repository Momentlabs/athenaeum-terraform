#
## Required Inputs
#
variable "environment" {
    description = "Naming environment for supporting clusters (eg. production or staging or development)."
}

variable "zone" {
    description = "google cloude zone where cluster will run (e.g. us-west1-a)"
}

variable "machine_type" {
    description = "machine type for the default node pool (e.g. f1-micro or n1-standard-1 or n1-standard-4)"
}

variable "admin_user" {
    description = "Create a clusterrole for this user."    
}

variable "initial_node_count" {
    description = "Number of initial nodes in the node pool"
}

#
# Optional Paramaters
#
variable "google_creds_file" {
    description = "Location of file with gcloud credentials (e.g account.json)"
    default = "account.json"
}

variable "project" {
    description  = "google cloud project where we will create the cluster."
    default = "momentlabs-jupyter"
}

variable "product_name" {
    description = "High level name for the app or product"
    default = "athenaeum-notebooks"
}

variable "cluster_number" {
    description = "This is really a place holder becasue Im not yet sure about how this will work."
    default = 1
}

variable "enable_helm" {
    description = "Install helm in to the cluster if enabled."
    default = true
}

