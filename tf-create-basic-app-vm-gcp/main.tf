

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

# define the resource
resource "google_compute_instance" "tech504-becky-tf-app-vm" {
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  machine_type  = var.machine_type
  name          = var.instance-name

  metadata = {
    enable-osconfig = "TRUE"
    startup-script  = var.start-up-script
  }

  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
}

