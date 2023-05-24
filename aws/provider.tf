provider "aws" {
  region  = var.region
  profile = var.profile[terraform.workspace]
}

provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
  profile = var.profile[terraform.workspace]
}


provider "kubernetes" {
  config_context = terraform.workspace
}

provider "tls" {
}
