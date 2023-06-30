terraform {
  backend "s3" {
    key                  = "monitoring_filecoin.tfstate"
    workspace_key_prefix = "terraform"
  }
}
