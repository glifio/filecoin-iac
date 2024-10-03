data "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
}

data "aws_eks_cluster" "k8s_cluster" {
  name = var.kubernetes_cluster_name
}

data "aws_eks_cluster_auth" "k8s_cluster_auth" {
  name = var.kubernetes_cluster_name
}

data "aws_lb" "default" {
  tags = {
    Name = var.elb_name_tag
  }
}

data "aws_route53_zone" "default" {
  name         = var.domain_zone
  private_zone = false
}
