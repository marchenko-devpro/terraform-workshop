/*---------------- Generete SSH key for admin access ----------------*/
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
/*---------------- Generate admin password --------------------------*/
resource "random_string" "password" {
  length      = 16
  special     = true
  min_numeric = 4
  min_upper   = 4
}

resource "random_string" "adminpassword" {
  length      = 12
  special     = false
  min_numeric = 4
  min_upper   = 4
}
/*---------------- Generate db user password -------------------------*/

resource "random_string" "userpassword" {
  length      = 12
  special     = false
  min_numeric = 4
  min_upper   = 4
}
resource "random_integer" "database-id" {
  min     = 1
  max     = 99999
}

