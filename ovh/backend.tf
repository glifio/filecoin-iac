terraform {
  backend "s3" {
    key                  = "ovh_filecoin.tfstate"
    workspace_key_prefix = "terraform"
  }
}
