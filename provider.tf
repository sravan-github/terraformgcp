# Specify the provider (GCP, AWS, Azure)
provider "google" {
credentials = "${file("/home/sravangcp/key.json")}"
project = "web-project-333613"
region = "us-central1"
}