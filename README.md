# tf-module-mutable-app

gp; terrafile -f ./env-dev/Terrafile; terraform init --backend-config=env-dev/backend-dev.tfvars; terraform plan -var APP_VERSION=001 --var-file env-dev/dev.tfvars; terraform apply -auto-approve -var APP_VERSION=001 --var-file env-dev/dev.tfvars