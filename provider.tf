# Specify the provider (GCP, AWS, Azure)
provider "google" {
credentials = "${file("/var/lib/jenkins/workspace/gcp-vm/key.json")}"
project = "web-project-333613"
region = "us-central1"
}
