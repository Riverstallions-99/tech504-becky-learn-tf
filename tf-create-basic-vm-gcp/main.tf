# Creating an ec2 instance:

provider "google" {
  project = "sparta-academy-455414"
  region  = var.region
  zone    = var.zone
  impersonate_service_account = "white.rebecca2012@gmail.com"
}

# define the resource
resource "google_compute_instance" "tech504-becky-tf-basic-vm" {
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  machine_type = var.machine_type
  name = "tech504-becky-tf-app-vm"

  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
}

