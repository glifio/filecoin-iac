provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "local" {}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.k8s_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.k8s_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.k8s_cluster_auth.token
}
