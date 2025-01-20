terraform {
  required_version = "1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }
}
