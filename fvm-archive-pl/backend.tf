terraform {
  backend "s3" {
    key                  = "fvm-archive-pl.tfstate"
    workspace_key_prefix = "terraform"
  }
}
