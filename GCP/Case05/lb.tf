resource "google_compute_target_pool" "http-lb" {
  name = "instance-pool"
  region = "${var.region}"

  instances = [
    #"us-east1-b/"test-web-0"",
    #"us-east1-c/test-web-1"
    "${element(var.zone, count.index)}/${element(google_compute_instance.vm.*.name, count.index)}"
  ]

  health_checks = [
    "${google_compute_http_health_check.http-lb-health.name}"
  ]
}


resource "google_compute_http_health_check" "http-lb-health" {
  name               = "http-lb-health"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}