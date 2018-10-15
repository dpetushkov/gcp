resource "google_compute_instance" "ubuntu-xenial1" {
   name = "ubuntu-xenial1"
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

resource "google_compute_instance" "ubuntu-xenial2" {
   name = "ubuntu-xenial2"
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

resource "google_compute_instance" "ubuntu-xenial3" {
   name = "ubuntu-xenial3"
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

resource "google_compute_target_pool" "default" {
  name = "instance-pool"

  instances = [
    "us-west1-a/ubuntu-xenial1",
    "us-west1-a/ubuntu-xenial2",
    "us-west1-a/ubuntu-xenial3",
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
  target     = "instance-pool"
  port_range = "80"
}

