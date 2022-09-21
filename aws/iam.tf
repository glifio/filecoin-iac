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
