# Cheatsheet

| Command | Working Directory | Explanation |
| --- | --- | --- |
| `terraform init -backend-config=../filecoin-glif-dev-apn1.hcl` | `./aws`, `./k8s` or `./user_management` | Initialize dev env |
| `terraform init -backend-config=../filecoin-glif-dev-apn1.hcl -reconfigure` | `./aws` or `./k8s` | Switch to and init dev env |
| `terraform init -backend-config=../filecoin-glif-mainnet-apn1.hcl` | `./aws` or `./k8s` | Initialize mainnet env |
| `terraform init -backend-config=../filecoin-glif-mainnet-apn1.hcl -reconfigure` | `./aws` or `./k8s` | Switch to and init mainnet env |
| `terraform workspace select filecoin-glif-mainnet-apn1` | `./aws` | Switch to mainnet workspace |
| `terraform workspace select filecoin-glif-dev-apn1` | `./aws` | Switch to mainnet workspace |
| `terraform workspace select filecoin-mainnet-apn1-glif-eks` | `./k8s` | Switch to mainnet workspace |
| `terraform workspace select filecoin-dev-apn1-glif-eks` | `./k8s` | Switch to mainnet workspace |
| `terraform plan -var-file=tfvars/filecoin-glif-dev-apn1.tfvars` | `./aws` or `./k8s` | Create plan for dev workspace |
| `terraform plan -var-file=tfvars/filecoin-glif-mainnet-apn1.tfvars` | `./aws` or `./k8s` | Create plan for mainnet workspace |
| `terraform plan -var-file=tfvars/filecoin-users.tfvars` | `./user_management` | Create plan for user management |
| `terraform state rm` | `./aws` or `./k8s` | Delete resource from state |
| `terraform import -var-file=tfvars/filecoin-glif-dev-apn1.tfvars <resourceName> <resourceId>` | `./aws` or `./k8s` | Import resource to dev |
| `terraform import -var-file=tfvars/filecoin-glif-mainnet-apn1.tfvars <resourceName> <resourceId>` | `./aws` or `./k8s` | Import resource to mainnet |
| `git fetch --all` and `git pull --rebase=i --autostash origin main` | anywhere | Rebase on main |
