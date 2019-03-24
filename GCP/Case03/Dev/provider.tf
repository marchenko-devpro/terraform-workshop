/*------------ Provider GCP -------------------*/
provider "google" {
  credentials	= "${file("${var.path_to_context}")}"
  project    	= "${var.project_name}"
  region     	= "${var.region}"
}

terraform {
  backend "gcs" {
    bucket  = "test-tf-state-ie"
    prefix  = "terraform/dev"
    credentials	= "/Users/sergii.marchenko/work/keys/gcp/Iegor-072a850167f3.json"
  }
}