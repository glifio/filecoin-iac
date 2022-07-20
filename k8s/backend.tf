terraform {
  backend "s3" {
    key                  = "k8s_filecoin.tfstate"
    workspace_key_prefix = "terraform"
  }
}
