resource "google_sql_database_instance" "default" {
  name             = "tenpo-db"
  region           = var.region
  database_version = "POSTGRES_14"

  settings {
    tier = "db-custom-2-3840"
    ip_configuration {
      private_network = var.private_network
    }
  }
}
