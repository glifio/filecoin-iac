resource "aws_cloudwatch_log_group" "cloudwatch_eks_logs" {
  name              = "/aws/${module.generator.prefix}/eks/eks-cluster"
  retention_in_days = 60

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-cloudwatch-eks-master"
    },
    module.generator.common_tags
  )
}
