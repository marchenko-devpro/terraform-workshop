############################## SQL Pass ###########################
/*
data "vault_generic_secret" "sql" {
  path = "devopsflow/${var.environment}/сonfig"
}

*/
# Put info to vault for API, Identity, etc. components usage
resource "vault_generic_secret" "sqlpass" {
  path = "devopsflow/${var.environment}/config"

  data_json = <<EOT
{
  "sqlpass":           "${module.vm.sqlpass}"
}
EOT

}