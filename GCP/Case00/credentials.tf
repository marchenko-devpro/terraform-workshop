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

