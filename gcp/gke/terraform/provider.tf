terraform {
  required_version = "= 0.13.4"
  backend "gcs" {
    bucket  = "k8s-infra-310011-terraform-state-store"
  }
}

provider "google" {
  project     = "k8s-infra-310011"
  region      = "asia-northeast1"
}
