resource "google_compute_instance" "ubuntu-xenial" {
   count = 3
   name = "ubuntu-xenial${count.index + 1}"
   machine_type = "f1-micro"
   zone = "us-west1-a"
   boot_disk {
      initialize_params {
      image = "ubuntu-1604-lts"
   }
}

network_interface {
   network = "default"
   access_config {}
}
service_account {
   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
   }


}

output "ip" {
 value = "${google_compute_instance.ubuntu-xenial.network_interface.0.access_config.0.assigned_nat_ip}"
}


resource "google_compute_target_pool" "default" {
  name = "instance-pool"

  instances = [
    "us-west1-a/ubuntu-xenial1",
    "us-west1-a/ubuntu-xenial2",
    "us-west1-a/ubuntu-xenial3",
  ]

  health_checks = [
    "${google_compute_http_health_check.default.name}",
  ]

  region = "us-west1"


}

resource "google_compute_http_health_check" "default" {
  name               = "default"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_forwarding_rule" "default" {
  name       = "website-forwarding-rule"
  region     = "us-west1"
  target     = "${google_compute_target_pool.default.self_link}"
  port_range = "80"
}

