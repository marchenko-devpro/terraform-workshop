/* ---------------------- outputs -------------------------------------------------*/
output "vm_external_ip" {
  value = "${google_compute_instance.vm.network_interface.0.access_config.0.nat_ip}"
}

/*output "privet_key" {
  value = "\n${tls_private_key.ssh.private_key_pem}"
}*/

resource "local_file" "key" {
  content     = "\n${tls_private_key.ssh.private_key_pem}"
  filename = "key"
  provisioner "local-exec" {
    command = "chmod 600 key"
  }
}


