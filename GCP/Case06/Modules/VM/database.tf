/*---------------- Creation cloud SQL instance------------------*/
resource "google_sql_database_instance" "sql_instance" {
  name             = "${var.environment}-${random_integer.database-id.result}"
  database_version = "${var.db-version}"
  region           = "${var.region}"

  settings {
    tier = "db-${var.machine_type}"

    ip_configuration = {
      ipv4_enabled        = true
      authorized_networks = ["${data.null_data_source.auth_net_postgres_allowed.*.outputs}"]

      //ipv4_enabled = "false"
      //private_network = "${google_compute_network.vpc_network.self_link}"
    }
  }
}

/*----------- Create list of external IP for access to db------*/
/* This section is not nesseney if 11-13 line is
   commenteed and 14-15 is uncommented-------------------------*/

data "null_data_source" "auth_net_postgres_allowed" {
  count = "${var.count}"

  inputs = {
    name  = "vm-${count.index}"
    value = "${element(google_compute_instance.vm.*.network_interface.0.access_config.0.nat_ip, count.index)}"
  }
}

/*------------- Database creation-----------------------------*/
resource "google_sql_database" "database" {
  name     = "peopleDatabase"
  instance = "${google_sql_database_instance.sql_instance.name}"
}

/*------------- Creation db users ----------------------------*/
resource "google_sql_user" "sqladmin" {
  name     = "sqladmin"
  instance = "${google_sql_database_instance.sql_instance.name}"
  host     = "${var.domain_name}"
  password = "${random_string.adminpassword.result}"
}

resource "google_sql_user" "sqluser" {
  name     = "sqluser"
  instance = "${google_sql_database_instance.sql_instance.name}"
  host     = "${var.domain_name}"
  password = "${random_string.userpassword.result}"
}
