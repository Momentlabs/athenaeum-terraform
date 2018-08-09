# For some reason I never go keeping the provider configuraton
# in here to work properly. Probably not a very good idea.
# provider "google" {
#     # credentials = "${file("${path.root}/${var.google_creds_file}")}"
#     # credentials = "${file("${path.root}/account.json")}"
#     credentials = "/Users/jdr/Development/jupyter/athenaeum/athenaeum/terraform/account.json"
#     project = "${var.project}"
#     zone = "${var.zone}"
# }

# # TODO: It probably makes more sense to move this somewhere
# # internal so it can try and get the cluster variables right after the cluster
# # is created rather than pull them from kubectl config as set up by gcloud. 
# provider "kubernetes" {
#     host = "${module.gke.endpoint}"
# }

# Configure the cluster.
module "gke" {
    # source = "./gke"
    source = "git@github.com:Momentlabs/terraform-modules.git//gke"
    cluster_name = "${var.product_name}-${var.environment}-${var.cluster_number}"
    description = "${var.environment} cluster for ${var.product_name} #${var.cluster_number}"
    zone = "${var.zone}"
    machine_type = "${var.machine_type}"
    initial_node_count = "${var.initial_node_count}"
    cluster_admin_user = "${var.admin_user}"
    enable_helm = "${var.enable_helm}"
}
