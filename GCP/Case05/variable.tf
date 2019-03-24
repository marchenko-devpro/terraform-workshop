/* --------- Global variable for environment------------------*/
/* --------- This can be overridden by name.auto.tfvars ------*/
variable "region" {
  description = "GCP default region "
  default = "us-east1"
}
variable "project_name" {
    description = "The ID of the project in which the resource belongs"
    default     = "devproworkshop"
}
variable "zone" {
  description = "default zone"
  type        = "list"
  default     = ["us-east1-b","us-east1-c"]
}
variable "machine_type" {
    description = "Default type"
    default     = "g1-small"
}

variable "admin_user" {
  default = "ubuntu"
}

variable "environment" {
  default = "test"
}
variable "role" {
  default = "web"
}

variable "count" {
  default = 2
}

variable "db-version" {
  description = "default db version "
  default = "POSTGRES_9_6"
}

variable "domain_name" {
  description = "A name of domain where the record will be added. For example google.com"
  default = "xxxxxxxxxxxxxx.pp.ua"
}