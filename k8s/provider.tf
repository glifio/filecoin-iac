provider "aws" {
  region  = var.region
  profile = var.profile[terraform.workspace]
}

provider "aws" {
  region  = "us-east-1"
  alias   = "aws_global_resources"
  profile = var.profile[terraform.workspace]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.k8s_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.k8s_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.k8s_cluster_auth.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.k8s_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.k8s_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.k8s_cluster_auth.token
  }
}

provider "local" {
}

provider "uptimerobot" {
}