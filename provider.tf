# Specify the provider (GCP, AWS, Azure)
provider "google" {
#credentials = "${file("/var/lib/jenkins/workspace/gcp-vm/key.json")}"
project = "dolphine-project"
region = "us-central1"
}
