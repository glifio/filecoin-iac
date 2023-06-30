terraform {
  required_version = "1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.21.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    ovh = {
      source  = "ovh/ovh"
      version = "0.30.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}
