{
  "Version": "2012-10-17",
  "Statement": [
	{
	  "Effect": "Allow",
	  "Principal": {
		"Federated": "arn:aws:iam::${aws_account_id}:oidc-provider/${oidc}"
	  },
	  "Action": "sts:AssumeRoleWithWebIdentity",
	  "Condition": {
		"StringEquals": {
		  "${oidc}:aud": "sts.amazonaws.com",
		  "${oidc}:sub": "system:serviceaccount:kube-system:cronjob-sync-marketdeals"
		}
	  }
	}
  ]
}
