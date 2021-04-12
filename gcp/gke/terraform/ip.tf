resource "google_compute_global_address" "api_server_static_ip" {
  name    = "api-server-static-ip"
  project = var.project
}

output "api_server_static_ip" {
  value = google_compute_global_address.api_server_static_ip.address
}