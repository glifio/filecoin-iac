locals {
  aws_secret_name = "${module.generator.prefix}-${var.name}"
  k8s_secret_name = "${var.name}${var.k8s_secret_postfix}"

  k8s_secret_count = var.create_k8s_secret ? 1 : 0
}
