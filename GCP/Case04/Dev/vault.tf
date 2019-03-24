############################## SQL Pass ###########################

# Place some files info vault
resource "vault_generic_secret" "sqlpass" {
  path = "devopsflow/${var.project_name}/${var.environment}/config"

  data_json = <<EOT
{
  "sqlpass":           "${module.vm.sqlpass}"
}
EOT

}