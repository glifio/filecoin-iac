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
      version = "2.6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    uptimerobot = {
      source = "louy/uptimerobot"
      version = "0.5.1"
    }
  }
}
