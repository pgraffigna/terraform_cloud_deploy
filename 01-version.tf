terraform {
  required_providers {
    upcloud = {
      source = "UpCloudLtd/upcloud"
      version = "~>1.0.0"
    }
  }
}

provider "upcloud" {
}