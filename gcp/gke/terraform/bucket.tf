resource "google_storage_bucket" "deploy_bucket" {
  name     = "${var.project}-deploy-bucket"
  location = var.region
  storage_class = "REGIONAL"
}