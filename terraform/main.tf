provider "google" {
  project = "sero-388815"
}

module "app" {
  source = "./module"

  name   = "app"
  region = "europe-west1"
}
