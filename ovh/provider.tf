provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "local" {}

provider "ovh" {
  endpoint           = local.endpoint
  application_key    = local.application_key
  application_secret = local.application_secret
  consumer_key       = local.consumer_key
}
