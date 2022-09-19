{
  "Version": "2012-10-17",
  "Statement": [
	{
	  "Effect": "Allow",
	  "Action": [
		"secretsmanager:*",
		"ssm:*",
		"logs:*",
		"kms:*",
		"codeartifact:GetAuthorizationToken",
		"codeartifact:GetRepositoryEndpoint",
		"codeartifact:ReadFromRepository",
		"sts:GetServiceBearerToken"
	  ],
	  "Resource": "*"
	}
  ]
}
