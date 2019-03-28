# we can create a static IP an uncomment 25 line to accociate it with vm
# which will be created
/*resource "google_compute_address" "static_ip" {
  name = "vmexternal"
}*/
/*------------------- Virtual machine------------------------*/
resource "google_compute_instance" "vm" {
  name                = "${var.environment}-${var.role}-${count.index}"
  zone                = "${element(var.zone, count.index)}"
  machine_type        = "${var.machine_type}"
  deletion_protection = false
  count               = "${var.count}"

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
      // Ephemeral IP  // static IP // nat_ip = "${google_compute_address.static_ip.address}"
    }
  }

  /*------------ User access data--------------------------------*/
  metadata {
    ssh-keys = "${var.admin_user}:${tls_private_key.ssh.public_key_openssh}"
  }

  /*------------ Required for firewall settings -----------------*/
  tags = [
    "${(var.environment)}",
    "${(var.role)}",
  ]

  /*---------------- User lables --------------------------------*/
  labels {
    name        = "${var.environment}-${var.role}"
    environment = "${var.environment}"
    role        = "${var.role}"
  }
}

resource "null_resource" "startupscript" {
  count = "${var.count}"

  connection {
    host        = "${element(google_compute_instance.vm.*.network_interface.0.access_config.0.nat_ip, count.index)}"
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${tls_private_key.ssh.private_key_pem}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir $HOME/work",
      "mkdir -p $HOME/work/src",
      "cd $HOME/work/src",
      "export GOPATH=$HOME/work",
      "git clone https://github.com/paperplane90/devopsworkshop.git",
      "cd $HOME/work/src/devopsworkshop/",
      "chmod 755 install.sh",
      "./install.sh > /dev/null",
      "sudo apt install go-dep -y",
      "export PGPASSWORD=${random_string.userpassword.result}",
      "pg_restore -h ${google_sql_database_instance.sql_instance.ip_address.0.ip_address}  -U sqluser -w -d peopleDatabase -C dumb.sql",
      "dep ensure",
      "echo #!/bin/bash > start.sh",
      "echo export DBPORT=5432 >> start.sh",
      "echo export DBHOST=${google_sql_database_instance.sql_instance.ip_address.0.ip_address} >> start.sh",
      "echo export DBUSER=sqluser >> start.sh",
      "echo export DBPASS=${random_string.userpassword.result} >> start.sh",
      "echo export DBNAME=peopleDatabase >> start.sh",
      "go build main.go personHandler.go store.go",
      "echo './main' >> start.sh",
      "chmod 755 start.sh",
      "sudo nohup ./start.sh > /dev/null 2>&1 < /dev/null &",
      "sleep 1",
      "echo Finished",
    ]
  }
}
