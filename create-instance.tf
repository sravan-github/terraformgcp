/*resource "google_compute_address" "static" {
  name = "ipv4-address"
}*/
resource "google_compute_instance" "default" {
  #count = 2
  name         = "nexusvm"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

metadata = {
    ssh-keys = "nexus:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkOmOQISBqFwOeCsC/BvoyCUgzf6FTrKMAGj7+2mdPNaLBOxFzBypztb+hOFk57C46gEFout3kyqjl0I1CJ4Os++KEUQPdTHuwL5widGAep7HaIUSuDssjKywVjKJQWmfUjk6Fsob12bgcIUb+bbFcMQ8VBck7JAttnh/lBLvk1CfFYjq5TH80J/wWwQDIZB4pxxag9jp2s23nWXhtwk1Ft4kCPiCXf+KOxe4VrMABDT/grTTAZY2n3SrUyq+wOfdJhGRmbohbJAVxmZCmJckaUajSdnHI6Gj0yVafjJf20jzXz2cz0eLI/gMr4wTBPSv1B0rBra3Pd2ntHy9o52SF nexus"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
 

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
     // nat_ip = google_compute_address.static.address
    }
  }
  
  provisioner "remote-exec" {
    connection {
      host        = google_compute_address.static.address
      type        = "ssh"
      user        = "nexus"
      timeout     = "500s"
      private_key = "${file("/home/sravangcp/nexus.pem")}"
    }
    inline = [
      "chmod +x ~/nexus.sh",
      "cd ~",
      "./nexus.sh",
    ]
  }
  
  //  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "admin-account@dolphine-project.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
    // Apply the firewall rule to allow external IPs to access this instance
    tags = ["http-server"]

}


output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
