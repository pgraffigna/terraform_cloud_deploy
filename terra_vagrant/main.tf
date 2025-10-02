terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "postgres" {
  name         = "postgres:17.5-alpine"
  keep_locally = true
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.image_id

  tmpfs = {
    "/var/lib/postgresql/data" = ""
  }

  env = [
    "POSTGRES_USER=${var.APP_DB_ADMIN_USER}",
    "POSTGRES_PASSWORD=${var.APP_DB_ADMIN_PASSWORD}",
    "POSTGRES_DB=${var.APP_DB_NAME}"
  ]

  ports {
    internal = 5432
    external = var.APP_DB_PORT
  }
}
