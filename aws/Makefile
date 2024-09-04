ENVIRONMENT=mainnet
# ENVIRONMENT=dev

init:
	terraform init -backend-config=../filecoin-glif-$(ENVIRONMENT)-apn1.hcl

reinit:
	terraform init -backend-config=../filecoin-glif-$(ENVIRONMENT)-apn1.hcl -reconfigure

upgrade:
	terraform init -backend-config=../filecoin-glif-$(ENVIRONMENT)-apn1.hcl -upgrade

select:
	terraform workspace select filecoin-glif-$(ENVIRONMENT)-apn1

plan:
	terraform plan -var-file=tfvars/filecoin-glif-$(ENVIRONMENT)-apn1.tfvars -out=tfplan

apply:
	terraform apply tfplan
