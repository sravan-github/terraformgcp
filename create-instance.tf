resource "google_compute_instance" "default" {
  name         = "virtual-machine-from-terraform"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  
  metadata = {
    ssh-keys = "testuser:ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAifGBisNw/lYu+v7WWOtZK1fWeYVCRRN/GijAqBsveF0yvDuRB1SY1tNWnp2/ZSkACEEXgfnKIQgINmQr4er3CFACDoHD3voN6gxh33IV/+UXiiUPZUUHip/dbWENsDrUj1sWpL90zB2t+IkrULZvRkm9yz7ztZB5ZFofb4G4eVvdciUSG6xuogCHLkKUpCDMRjmciA/Z+gDRjGi3cfk66P+hgA9VrcmCGlJDB4+uFnpMTQXGNz3UJLDh7f9ehKMLFztzW8ZT/LfxSEpfMfGQow7w5duKH/UbTHsDH/rSoQMlLfzs+hz84AuZzicdPa+3SDYPHrfoGWCBu8RvURUXmw== testuser"
  }

  boot_disk {
    initialize_params {
      //image = "debian-cloud/debian-9"
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

    metadata_startup_script = "sudo apt-get update && apt install python -y"

    service_account {
    email  = "admin-account@dolphine-project.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
    tags = ["http-server"]
}

//resource "google_compute_firewall" "http-server" {
//  name    = "default-allow-http-terraform"
//  network = "default"

//  allow {
//    protocol = "tcp"
//    ports    = ["80"]
//  }

  // Allow traffic from everywhere to instances with an http-server tag
//  source_ranges = ["0.0.0.0/0"]
//  target_tags   = ["http-server"]
//}


output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
