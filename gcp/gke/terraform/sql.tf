resource "google_sql_database_instance" "mysql" {
  provider = google-beta

  name = "mysql"
  database_version = "MYSQL_8_0"
  region       = var.region

  settings {
    tier = "db-f1-micro"
    disk_size = 10
    //    ip_configuration {
    //      ipv4_enabled    = false
    //      private_network = google_compute_network.network.id
    //    }
  }
}

resource "google_sql_user" "users" {
  name     = "user"
  instance = google_sql_database_instance.mysql.name
  host     = "%"
  password = "password"
}

resource "google_sql_database" "database" {
  name      = "test_database"
  instance  = google_sql_database_instance.mysql.name
  charset   = "utf8mb4"
}