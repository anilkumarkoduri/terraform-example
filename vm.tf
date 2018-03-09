resource "google_compute_instance" "default" {
  name                      = "test-vm-${count.index}"
  machine_type              = "n1-standard-2"
  zone                      = "europe-west1-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
    }
  }

  attached_disk {
    source = "${element(google_compute_disk.default.*.name, count.index)}"
  }

  network_interface {
    network = "default"

    access_config {
      // Use Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "debian:${file("~/.ssh/id_rsa.pub")}"
  }

  count = "${var.my_counter}"
}

resource "google_compute_disk" "default" {
  name  = "test-disk-${count.index}"
  type  = "pd-ssd"
  zone  = "europe-west1-b"
  count = "${var.my_counter}"
}

variable "my_counter" {
  default = 1
}
