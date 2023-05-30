resource "google_sql_database" "database" {
  name     = var.name
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name             = var.name
  region           = var.region
  database_version = "POSTGRES_14"
  settings {
    tier = var.db_tier
    ip_configuration {
      ipv4_enabled                                  = false
      require_ssl                                   = true
      private_network                               = data.google_compute_network.vpc.id
      enable_private_path_for_google_cloud_services = true
    }
    database_flags {
      name  = "log_temp_files"
      value = "0"
    }
    database_flags {
      name  = "log_connections"
      value = "on"
    }
    database_flags {
      name  = "log_lock_waits"
      value = "on"
    }
    database_flags {
      name  = "log_disconnections"
      value = "on"
    }
    database_flags {
      name  = "log_checkpoints"
      value = "on"
    }
    backup_configuration {
      enabled = true
      backup_retention_settings {
        retained_backups = 1
      }
    }
  }

  deletion_protection = "false"
}
