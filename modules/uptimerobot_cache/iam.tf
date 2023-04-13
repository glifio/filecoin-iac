data "aws_iam_policy_document" "lambda_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_default" {
  name               = "${module.generator.prefix}-uptimerobot-cache-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_role.json
}

resource "aws_iam_role_policy_attachment" "lambda_default" {
  role       = aws_iam_role.lambda_default.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    actions = ["s3:*", "s3:GetObjectAttributes"]

    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_access" {
  name   = "${module.generator.prefix}-uptimerobot-cache-s3-access-policy"
  policy = data.aws_iam_policy_document.s3_access.json
}

resource "aws_iam_role_policy_attachment" "lambda_default_s3_access" {
  role       = aws_iam_role.lambda_default.name
  policy_arn = aws_iam_policy.s3_access.arn
}
