/* ---------------------- outputs -------------------------------------------------*/

output "vm_external_ip" {
  value = "${module.vm.vm_external_ip}"
}

output "sqlpass" {
  value = "${module.vm.sqlpass}"
}

output "LB_external_ip" {
  value = "${module.vm.LB_external_ip}"
}
