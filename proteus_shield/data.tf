data "aws_eks_cluster" "k8s_cluster" {
  name = local.kubernetes_cluster_name
}

data "aws_eks_cluster_auth" "k8s_cluster_auth" {
  name = local.kubernetes_cluster_name
}


data "aws_lb" "default" {
  tags = {
    Name = local.elb_name_tag
  }
}

data "aws_route53_zone" "default" {
  name         = local.domain_zone
  private_zone = false
}