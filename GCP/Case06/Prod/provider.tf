/*------------ Provider GCP -------------------*/
provider "google" {
  credentials	= "${file("${var.path_to_context}")}"
  project    	= "${var.project_name}"
  region     	= "${var.region}"
}

