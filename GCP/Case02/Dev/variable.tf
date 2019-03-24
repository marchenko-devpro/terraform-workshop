variable "project_name" {
  description = "The name of the project, might be Dev, QA, Prod"
}

variable "environment" {}

variable "region" {
  description = "GCP default region "
  default = "us-east1"
}

variable "path_to_context" {}