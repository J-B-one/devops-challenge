resource "google_compute_network" "vpc" {
  name = "tenpo-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "tenpo-subnet"
  region        = "us-central1"
  ip_cidr_range = "10.10.0.0/24"
  network       = google_compute_network.vpc.id
}

output "network_name" {
  value = google_compute_network.vpc.name
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}

output "network_self_link" {
  value = google_compute_network.vpc.self_link
}
