#resource "aws_iam_role" "codebuild_eks" {
#  name               = "${module.generator.prefix}-codebuild-eks"
#  description        = "${module.generator.prefix} codebuild eks role"
#  assume_role_policy = file("${path.module}/templates/roles/codebuild_eks_role.pol.tpl")
#
#  tags = merge(
#    {
#      "Name" = "${module.generator.prefix}-codebuild-eks"
#    },
#    module.generator.common_tags
#  )
#}
#
#resource "aws_iam_role_policy_attachment" "eks_policy" {
#  role       = aws_iam_role.eks_master.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#}
#
#resource "aws_iam_role_policy_attachment" "eks_controller_policy" {
#  role       = aws_iam_role.eks_master.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#}

resource "aws_iam_role" "cloudfront_cache_s3" {
  name = "cloudfront_cache_s3"

  assume_role_policy = file("${path.root}/templates/roles/cloudfront_cache_lambda.pol.tpl")
}

resource "aws_iam_policy" "cloudfront_cache_s3_policy" {
  name = "cloudfront_cache_s3_policy"
  policy = file("${path.root}/templates/policies/lambda_policy_to_cache_s3.pol.tpl")
}

resource "aws_iam_role_policy_attachment" "cloudfront_cache_s3" {
  role       = aws_iam_role.cloudfront_cache_s3.name
  policy_arn = aws_iam_policy.cloudfront_cache_s3_policy.arn
}
