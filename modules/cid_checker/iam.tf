
resource "aws_iam_role" "log-s3-lambda" {
  name = "log-s3-${var.bucket_name}-lambda"

  assume_role_policy = file("${path.module}/templates/roles/role_for_lambda.pol.tpl")
}

resource "aws_iam_role_policy_attachment" "LambdaRoleToAccessCloudWatchLogs" {
  role       = aws_iam_role.log-s3-lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
