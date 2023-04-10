{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowLambdaAccess",
      "Effect": "Allow",
      "Action": [
        "lambda:*"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowS3Access",
      "Effect": "Allow",
      "Action": [
        "s3:*",
        "s3:GetObjectAttributes"
      ],
      "Resource": [
        "arn:aws:s3:::cloudfront-cache-s3",
        "arn:aws:s3:::cloudfront-cache-s3/*"
      ]
    }
  ]
}