# setup the GCP provider
terraform {
  required_version = ">= 0.12"
}
provider "google" {
  project     = "dolphine-project"
  credentials = file("/home/sravangcp/gcp-key.json")
  region      = "europe-west1"
  zone        = "europe-west1-b"
}
