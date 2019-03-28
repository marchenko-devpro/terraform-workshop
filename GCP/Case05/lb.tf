resource "google_compute_target_pool" "http-lb" {
  name   = "instance-pool"
  region = "${var.region}"

  instances = [
    "${google_compute_instance.vm.*.self_link}",
  ]

  health_checks = [
    "${google_compute_http_health_check.http-lb-health.name}",
  ]
}

resource "google_compute_http_health_check" "http-lb-health" {
  name               = "http-lb-health"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
  port               = 8080
  
}

resource "google_compute_forwarding_rule" "default" {
  name       = "load-balancer-${var.region}"
  target     = "${google_compute_target_pool.http-lb.self_link}"
  port_range = "8080-8080"
}
