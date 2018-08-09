#
# Variables
#

variable "environment" {
    description = "Naming environment for supporting clusters (eg. production or staging or development)."
    default = "staging"
}

variable "cluster_zone" {
    description = "google cloude zone where cluster will run (e.g. us-west1-a)"
    default = "us-west1-c"
}

variable "cluster_machine_type" {
    description = "machine type for the default node pool (e.g. f1-micro or n1-standard-1 or n1-standard-4)"
    default="n1-standard-1"
}

variable "cluster_initial_node_count" {
    description = "Number of initial nodes in the node pool"
    default = 3
}

variable "admin_user" {
    description = "google cloud user name to use for creating the cluster."
    default = "david@momentlabs.io"
}

variable "cluster_project" {
    default = "momentlabs-jupyter"
}
variable "google_creds_file" {
    description = "google cloud keys and id for service_account provisoined for terraform"
    default = "account.json"
}
#
# Resources
#
provider "google" {
    credentials = "${file("${var.google_creds_file}")}"
    project = "${var.cluster_project}"
    zone = "${var.cluster_zone}"
}

# TODO: It probably makes more sense to move this somewhere
# internal so it can try and get the cluster variables right after the cluster
# is created rather than pull them from kubectl config as set up by gcloud. 
provider "kubernetes" {
    host = "${module.athenaeum_cluster.endpoint}"
}

module "athenaeum_cluster" {
    source = "../modules/athenaeum_cluster"
    environment = "${var.environment}"
    zone = "${var.cluster_zone}"
    machine_type = "${var.cluster_machine_type}"
    initial_node_count = "${var.cluster_initial_node_count}"
    admin_user = "${var.admin_user}"
}
data "google_container_cluster" "new_cluster" {
    name = "${module.athenaeum_cluster.cluster_name}"
}


#
# Outputs
#

output "cluster_name" {
    value = "${data.google_container_cluster.new_cluster.name}"
}

output "description" {
    value = "${data.google_container_cluster.new_cluster.description}"
}

# It's completely unclear to me why this doesn't work in the case
# where we have no cluster at first, but the others ones (e.g. machine_type) do.
# output "zone" {
#     value = "${data.google_container_cluster.new_cluster.zone}"
# }

output "machine_type" {
    value = "${data.google_container_cluster.new_cluster.node_config.0.machine_type}"
}

output "initial_node_count" {
    value = "${data.google_container_cluster.new_cluster.initial_node_count}"
}

output "cluster_endpoint" {
    value = "${data.google_container_cluster.new_cluster.endpoint}"
}
