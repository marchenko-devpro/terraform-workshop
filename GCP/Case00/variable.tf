/* --------- Global variable for environment------------------*/
/* --------- The default values will be overridden by name.auto.tfvars ------*/

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
  default     = "us-east1-c"
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
  default = 1
}

variable "path_to_context" {
  description = "Define the path to the context file"
}