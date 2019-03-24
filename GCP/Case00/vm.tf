/*------------------- Virtual machine ------------------------*/
resource "google_compute_instance" "vm" {
  name                  = "${var.environment}-${var.role}-1"
  zone                  = "${var.zone}"
  machine_type          = "${var.machine_type}"
  deletion_protection   = false

  boot_disk {
    auto_delete = true
    initialize_params {
      size  = "10"
      type  = "pd-standard"
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "${google_compute_network.vpc_network.self_link}"
    access_config {
    }
  }
/*------------ Add SSH key --------------------------------*/
  metadata {
    ssh-keys = "${var.admin_user}:${tls_private_key.ssh.public_key_openssh}"
  }

/*------------ Required for firewall settings -----------------*/
  tags = [
    "${(var.environment)}",
    "${(var.role)}"
    ]
/*---------------- User lables --------------------------------*/
  labels {
  name            = "${var.environment}-${var.role}"
  environment     = "${var.environment}"
  role            = "${var.role}"
  }
}
/*---------------- Remote exec --------------------------------*/
resource "null_resource" "startupscript" {

  connection {
    host     = "${google_compute_instance.vm.network_interface.0.access_config.0.nat_ip}"
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${tls_private_key.ssh.private_key_pem}"
  }
}