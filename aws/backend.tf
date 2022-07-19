terraform {
  backend "s3" {
    key                  = "aws_filecoin.tfstate"
    workspace_key_prefix = "terraform"
  }
}
