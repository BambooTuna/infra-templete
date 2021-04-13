resource "google_sql_database_instance" "mysql" {
  name = "mysql"
  database_version = "MYSQL_8_0"
  region       = var.region

  settings {
    tier = "db-g1-small"
    disk_size = 10
//    ip_configuration {
//      ipv4_enabled    = false
//      private_network = google_compute_network.network.self_link
//    }
  }

//  depends_on       = [google_service_networking_connection.private_vpc_connection]
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


# サービスアカウント作成
resource "google_service_account" "k8s-sql-proxy-connect" {
  account_id   = "k8s-sql-proxy-connect"
  display_name = "SQL Proxy Connection from k8s by terraform"
}
# 役割に"編集者"を設定
# TODO Don't delete: このTerraformを実行しているサービスアカウントのロールが編集者だけではダメで、セキュリティ管理者がついていないとダメだった
resource "google_project_iam_member" "k8s-sql-proxy-connect-iam-projectEditor" {
  depends_on = [google_service_account.k8s-sql-proxy-connect]
  role       = "roles/cloudsql.client"
  member     = "serviceAccount:${google_service_account.k8s-sql-proxy-connect.email}"
}
# サービスアカウントキーを取得
resource "google_service_account_key" "k8s-sql-proxy-connect-cred" {
  service_account_id = google_service_account.k8s-sql-proxy-connect.email
}
# kubernetes_secret で base64decodeしたprivate_keyを渡す！
resource "kubernetes_secret" "cloudsql-instance-credentials" {
  depends_on = [google_project_iam_member.k8s-sql-proxy-connect-iam-projectEditor]

  metadata {
    name = "cloudsql-instance-credentials"
  }

  data = {
    "credentials.json" = base64decode(google_service_account_key.k8s-sql-proxy-connect-cred.private_key)
  }

}


output "mysql_endpoint" {
  value = google_sql_database_instance.mysql.ip_address
}