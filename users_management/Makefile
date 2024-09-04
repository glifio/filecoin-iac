init:
	terraform init -backend-config=../filecoin-glif-dev-apn1.hcl

plan:
	terraform plan -var-file=tfvars/filecoin-users.tfvars -out=tfplan

apply:
	terraform apply tfplan