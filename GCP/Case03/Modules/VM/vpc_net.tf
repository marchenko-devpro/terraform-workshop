/*------------------- Create VPC main-network -------------------------*/
resource "google_compute_network" "vpc_network" {
  name                      = "${var.environment}-vnet"
  project                   = "${var.project_name}"
  description               = "project network"
  auto_create_subnetworks   = true
}
/*------------------- VPC firewall rules -----------------------*/
resource "google_compute_firewall" "firewall_external" {
/*-------------- Allow external access -------------------------*/
  name    = "allowaccesfromdp"
  network = "${google_compute_network.vpc_network.name}"
  priority = 1100
  allow {
    protocol = "tcp"
    ports    = ["80", "443" ,"8200", "22", "8080"]
  }
  allow {
    protocol = "udp"
    ports    = ["80", "443" ,"8200", "22", "8080"]
  }
  source_ranges = ["195.88.124.221/32", "82.207.109.122/32",]
  target_tags   = ["${var.environment}"]
}
resource "google_compute_firewall" "firewall_internal" {
/*------------- Allow internal access ---------------------------*/
  name    = "defaultinternaltraffic"
  network = "${google_compute_network.vpc_network.name}"
  priority = 1110
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  source_ranges = ["10.128.0.0/9"]
  target_tags   = ["${var.environment}"]
}