variable "APP_DB_ADMIN_USER" {
  description = "db_admin"
  type        = string
}

variable "APP_DB_ADMIN_PASSWORD" {
  description = "db_admin password"
  type        = string
  sensitive   = true
}

variable "APP_DB_NAME" {
  description = "db_name"
  type        = string
}

variable "APP_DB_PORT" {
  description = "db_port"
  type        = number
  default     = 5432
}
