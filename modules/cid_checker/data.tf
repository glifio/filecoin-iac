data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "k8s_cluster" {
  name = terraform.workspace
}