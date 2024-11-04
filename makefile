.PHONY: apply
apply: .terraform
	./check_update.sh
	terraform apply

.terraform:
	terraform init
