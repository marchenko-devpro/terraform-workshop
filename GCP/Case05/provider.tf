/*------------ Provider GCP-------------------*/
provider "google" {
  credentials	= "${file("~/work/keys/gcp/credentials.json")}"
  project    	= "${var.project_name}"
  region     	= "${var.region}"
}
