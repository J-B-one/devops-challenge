terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "gke" {
  source            = "./modules/gke"
  region            = var.region
  network           = module.vpc.network_name
  subnetwork        = module.vpc.subnet_name
}

module "sql" {
  source          = "./modules/sql"
  region          = var.region
  private_network = module.vpc.network_self_link
}
