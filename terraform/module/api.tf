data "archive_file" "api" {
  type        = "zip"
  source_dir  = "../${path.root}/data"
  output_path = "../${path.root}/build/api.zip"
}

resource "google_storage_bucket" "api" {
  name                        = "sero-${var.name}-api"
  location                    = "EU"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "api" {
  name   = "api.zip"
  bucket = google_storage_bucket.api.name
  source = "../${path.root}/build/api.zip"
}

resource "google_cloudfunctions_function" "api" {
  name        = "${var.name}-api"
  description = "A public API for accessing the stored data"
  runtime     = "nodejs18"
  region      = var.region

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.api.name
  source_archive_object = google_storage_bucket_object.api.name
  trigger_http          = true
}

resource "google_cloudfunctions_function_iam_member" "api_invoker" {
  project        = google_cloudfunctions_function.api.project
  region         = google_cloudfunctions_function.api.region
  cloud_function = google_cloudfunctions_function.api.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
