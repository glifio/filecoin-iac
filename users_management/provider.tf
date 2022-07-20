provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "kubernetes" {
  alias                  = "k8s_cluster_testnet"
  host                   = data.aws_eks_cluster.k8s_cluster_testnet.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.k8s_cluster_testnet.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.k8s_cluster_auth_testnet.token
}

#
#provider "kubernetes" {
#  alias = "k8s_cluster_mainnet"
#  host                   = data.aws_eks_cluster.k8s_cluster_mainnet.endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.k8s_cluster_mainnet.certificate_authority[0].data)
#  token                  = data.aws_eks_cluster_auth.k8s_cluster_auth_mainnet.token
#}
