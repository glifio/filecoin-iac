terraform {
  backend "s3" {
    key                  = "user_management_filecoin.tfstate"
    workspace_key_prefix = "terraform"
  }
}
