resource "google_container_cluster" "main" {
  name               = "container-cluster"
  location           = var.cluster_zone
  initial_node_count = 2
  network            = google_compute_network.network.name
  subnetwork         = google_compute_subnetwork.subnetwork-01.name

  enable_legacy_abac = true

  master_auth {
    username = ""
    password = ""
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "sleep 30"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    preemptible  = true
    machine_type = "n1-standard-1"
    disk_size_gb = 10
    disk_type    = "pd-standard"
  }
}