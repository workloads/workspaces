# Makefile for HCP Terraform Workspaces Seeding

# configuration
ARGS  :=
MAKEFILE_TITLE = 🟣 HCP TERRAFORM WORKSPACES

include ../tooling/make/configs/shared.mk
include ../tooling/make/functions/shared.mk
include ../tooling/make/configs/github.mk
include ../tooling/make/functions/terraform.mk
include ../tooling/make/targets/shared.mk

.SILENT .PHONY: print-secrets
print-secrets: # print (sanitized) environment variables [Usage: `make print-secrets`]
	$(call print_secrets,"TF_VAR")

.SILENT .PHONY: terraform
terraform: # execute Terraform with a specific command [Usage: `make terraform command=plan`]
	$(if $(command),,$(call missing_argument,command=init))

	# see https://developer.1password.com/docs/cli/reference/commands/run
	$(BINARY_OP) \
		run \
			--account="$(ONEPASSWORD_ACCOUNT)" \
			--env-file="$(ONEPASSWORD_SECRETS_FILE)" \
			-- \
			$(BINARY_TERRAFORM) $(command) $(ARGS)

.SILENT .PHONY: import
import: # execute a Terraform Import [Usage: `make import local=<Terraform Resource Identifier> remote=<Remote API identifier>`]
	$(if $(local),,$(call missing_argument,local=<Terraform Resource Identifier> remote=<Remote API Identifier>))
	$(if $(remote),,$(call missing_argument,local=<Terraform Resource Identifier> remote=<Remote API Identifier>))

	# see https://developer.1password.com/docs/cli/reference/commands/run
	$(BINARY_OP) \
		run \
			--account="$(ONEPASSWORD_ACCOUNT)" \
			--env-file="$(ONEPASSWORD_SECRETS_FILE)" \
			-- \
			$(BINARY_TERRAFORM) \
				import \
					'$(local)' '$(remote)'

.SILENT .PHONY: state-rm
state-rm: # execute a Terraform State Deletion [Usage: `make state-rm item=<Terraform Resource Identifier>`]
		$(if $(item),,$(call missing_argument,local=<Terraform Resource Identifier> remote=<Remote API Identifier>))

	# see https://developer.1password.com/docs/cli/reference/commands/run
	$(BINARY_OP) \
		run \
			--account="$(ONEPASSWORD_ACCOUNT)" \
			--env-file="$(ONEPASSWORD_SECRETS_FILE)" \
			-- \
			$(BINARY_TERRAFORM) \
				state \
					rm \
					'$(item)'
