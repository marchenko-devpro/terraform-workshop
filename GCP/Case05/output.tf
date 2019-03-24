/* ---------------------- outputs -------------------------------------------------*/
output "vpc_net_self_link" {
  value = "${google_compute_network.vpc_network.self_link}"
}

output "vm_external_ip" {
  value = "${google_compute_instance.vm.*.network_interface.0.access_config.0.nat_ip}"
}

output "privet_key" {
  value = "\n${tls_private_key.ssh.private_key_pem}"
}

output "instance_name" {
  value = "${google_compute_instance.vm.*.name}"
}

output "sql-IP" {
  value = "${google_sql_database_instance.sql_instance.ip_address.0.ip_address}"
}



