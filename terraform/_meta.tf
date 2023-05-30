terraform {
  required_version = "1.0.2"
  backend "gcs" {
    bucket = "sero-tf-state"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.67.0"
    }
  }
}
