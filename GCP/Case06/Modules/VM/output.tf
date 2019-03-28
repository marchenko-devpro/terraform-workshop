/* ---------------------- outputs -------------------------------------------------*/
resource "local_file" "key" {
  content  = "\n${tls_private_key.ssh.private_key_pem}"
  filename = "key"

  provisioner "local-exec" {
    command = "chmod 600 key"
  }
}

output "vm_external_ip" {
  value = "${google_compute_instance.vm.*.network_interface.0.access_config.0.nat_ip}"
}

output "sqlpass" {
  value = "${random_string.adminpassword.result}"
}

output "LB_external_ip" {
  value = "http://${google_compute_forwarding_rule.default.ip_address}:8080"
}
