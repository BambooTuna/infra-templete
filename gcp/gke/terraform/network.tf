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

//resource "google_compute_global_address" "private_ip_block" {
//  name         = "private-ip-block"
//  purpose      = "VPC_PEERING"
//  address_type = "INTERNAL"
//  ip_version   = "IPV4"
//  prefix_length = 20
//  network       = google_compute_network.network.self_link
//}
//
//resource "google_service_networking_connection" "private_vpc_connection" {
//  network                 = google_compute_network.network.self_link
//  service                 = "servicenetworking.googleapis.com"
//  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]
//}