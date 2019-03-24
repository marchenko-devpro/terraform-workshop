provider "google" {
  credentials = "${file("/Users/sergii.marchenko/work/keys/gcp/Iegor-072a850167f3.json")}"
  project     = "learned-acolyte-221721"
  region      = "us-west1-b"
}

resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-ssd"
  zone  = "us-west1-b"
  image = "debian-8-jessie-v20170523"
  labels = {
    environment = "dev"
  }
}