data "aws_eks_cluster" "default" {
  name = local.aws_eks_cluster_name
}

data "aws_eks_cluster_auth" "default" {
  name = local.aws_eks_cluster_name
}

data "aws_route53_zone" "default" {
  name         = local.route53_hosted_zone
  private_zone = false
}

data "aws_lb" "default" {
  tags = {
    Name = local.ingress_class_lb
  }
}

data "aws_secretsmanager_secret" "monitoring" {
  name = "${module.generator.prefix}-monitoring"
}

data "aws_secretsmanager_secret_version" "monitoring" {
  secret_id = data.aws_secretsmanager_secret.monitoring.id
}
