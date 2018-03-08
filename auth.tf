// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "terraform-test-197317"
  region      = "europe-west1 "
}
