terraform {
  backend "s3" {
    key                  = "proteus-shield.tfstate"
    workspace_key_prefix = "terraform"
  }
}
