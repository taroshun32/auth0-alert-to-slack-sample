terraform {
  required_version = "1.4.1"

  backend "local" {
    path = "./terraform.tfstate"
  }

  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 0.45.0"
    }
  }
}

provider "auth0" {}
