{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::${sync_marketdeals_s3_bucket}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:ListObject",
                "s3:PutObjectAcl"
            ],
            "Resource": "arn:aws:s3:::${sync_marketdeals_s3_bucket}/*"
        }
    ]
}