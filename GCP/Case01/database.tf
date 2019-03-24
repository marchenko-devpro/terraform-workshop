/*---------------- Create cloud SQL instance------------------*/
resource "google_sql_database_instance" "sql_instance" {
  name              = "${var.environment}-${random_integer.database-id.result}"
  database_version  = "${var.db-version}"
  region            = "${var.region}"
  
  settings {
    tier             = "db-${var.machine_type}"
    ip_configuration = {
      ipv4_enabled      = true
      authorized_networks = [
        "${data.null_data_source.auth_net_postgres_allowed.outputs}",
      ]
    }
  }
}
/*----------- Create list of external IP for access to db------*/
data "null_data_source" "auth_net_postgres_allowed" {

  inputs = {
    name  = "${google_compute_instance.vm.name}"
    value = "${google_compute_instance.vm.network_interface.0.access_config.0.nat_ip}"

  }
}
/*------------- Create Database-----------------------------*/
resource "google_sql_database" "database" {
  name      = "peopleDatabase"
  instance  = "${google_sql_database_instance.sql_instance.name}"
}
/*------------- Create db users ----------------------------*/
resource "google_sql_user" "sqladmin" {
  name     = "sqladmin"
  instance = "${google_sql_database_instance.sql_instance.name}"
  password = "${random_string.adminpassword.result}"
}

resource "google_sql_user" "sqluser" {
  name     = "sqluser"
  instance = "${google_sql_database_instance.sql_instance.name}"
  password = "${random_string.userpassword.result}"
}


