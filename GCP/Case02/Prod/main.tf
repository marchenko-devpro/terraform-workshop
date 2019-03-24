module "vm" {
  source = "../Modules/VM/"
  environment = "${var.environment}"
  region = "${var.region}"
  project_name = "${var.project_name}"
}