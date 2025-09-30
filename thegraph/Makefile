lint:
	terraform fmt

init:
	terraform init -backend-config=../filecoin-glif-mainnet-apn1.hcl

plan:
	terraform plan -out=tfplan

apply:
	terraform apply tfplan
