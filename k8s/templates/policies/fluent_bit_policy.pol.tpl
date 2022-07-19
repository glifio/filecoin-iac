{
  "Version": "2012-10-17",
  "Statement": [
	{
	  "Action": "es:ESHttp*",
	  "Resource": "arn:aws:es:${aws_region}:${aws_account_id}:domain/${os_domain_name}",
	  "Effect": "Allow"
	}
  ]
}
