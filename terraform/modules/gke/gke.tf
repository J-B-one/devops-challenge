resource "google_container_cluster" "primary" {
  name     = "tenpo-gke-private"
  location = "us-central1"

  networking_mode = "VPC_NATIVE"
  remove_default_node_pool = true

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
  }
}

resource "google_container_node_pool" "nodes" {
  name       = "nodepool"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = 3

  node_config {
    machine_type = "e2-medium"
  }
}
