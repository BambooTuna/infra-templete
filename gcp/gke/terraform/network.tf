resource "google_compute_network" "network" {
  name                    = "network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork-01" {
  name                     = "subnetwork-01"
  ip_cidr_range            = "10.10.10.0/24"
  network                  = google_compute_network.network.self_link
  region                   = var.region
  private_ip_google_access = true
}

