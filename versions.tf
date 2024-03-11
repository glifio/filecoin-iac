terraform {
  required_version = "1.3.1"

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
      version = "2.13.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.2"
    }
    ovh = {
      source  = "ovh/ovh"
      version = "0.30.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }
}
