

provider "google" {
  project = "sparta-academy"
  region  = "europe-west9"
}

# define the resource
resource "google_compute_instance" "tech504-becky-tf-app-vm" {
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  zone          = "europe-west9-b"
  machine_type  = var.machine_type
  name          = var.instance-name

  metadata = {
    enable-osconfig = "TRUE"
    startup-script  = "#!/bin/bash\n# Tested: 2025-05-07\n# Tested by: Becky\n# Tested on: GCP, Ubuntu 20.04 LTS\n# Result:\n\ncd /sparta-test-app-repo/app\necho ------ Running npm install... ------\nnpm install\necho\n\necho ------ Changing Adding DB_HOST variable... ------\nexport DB_HOST=mongodb://10.200.0.27:27017/posts\necho\n\necho ------ Starting Sparta App in background with pm2... ------\npm2 start app.js\necho"
  }

  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
}

