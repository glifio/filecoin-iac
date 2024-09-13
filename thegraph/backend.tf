terraform {
  backend "s3" {
    key                  = "thegraph.tfstate"
    workspace_key_prefix = "terraform"
  }
}
