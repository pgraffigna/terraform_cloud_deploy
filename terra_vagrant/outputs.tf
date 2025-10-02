output "db_connection_string" {
  value = "postgresql://${var.APP_DB_ADMIN_USER}:${var.APP_DB_ADMIN_PASSWORD}@localhost:${var.APP_DB_PORT}/${var.APP_DB_NAME}"
  sensitive = true
}

# terraform output db_connection_string