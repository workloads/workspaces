# Makefile for Terraform Cloud Workspaces Seeding

# configuration
ARGS        :=
TITLE        = 🟣 TERRAFORM CLOUD WORKSPACES
OP_ENV_FILE  = workspaces.op.env

include ../tooling/make/configs/shared.mk

include ../tooling/make/functions/shared.mk

# include Terraform-generated configuration data
include ../tooling/make/configs/github.mk

include ../tooling/make/functions/maintenance.mk

include ../tooling/make/targets/shared.mk

.SILENT .PHONY: print-secrets
print-secrets: # print (sanitized) environment variables [Usage: `make print-secrets`]
ifeq ($(strip $(BINARY_OP)),)
	$(error 🛑 Missing required 1Password CLI)
endif

	$(call print_secrets,"TF_VAR")

.SILENT .PHONY: terraform
terraform: # execute Terraform with a specific command [Usage: `make terraform command=plan`]
	$(if $(command),,$(call missing_argument,terraform,command=init))

ifeq ($(strip $(BINARY_OP)),)
	$(error 🛑 Missing required 1Password CLI)
endif

	# see https://developer.1password.com/docs/cli/reference/commands/run
	op \
		run \
			--account="$(OP_ACCOUNT)" \
			--env-file="$(OP_ENV_FILE)" \
			-- \
			terraform $(command) $(ARGS)

.SILENT .PHONY: import
import: # execute a Terraform Import [Usage: `make import local=<Terraform Resource Identifier> remote=<Remote API identifier>`]
	$(if $(local),,$(call missing_argument,import,local=<Terraform Resource Identifier> remote=<Remote API Identifier>))
	$(if $(remote),,$(call missing_argument,import,local=<Terraform Resource Identifier> remote=<Remote API Identifier>))

ifeq ($(strip $(BINARY_OP)),)
	$(error 🛑 Missing required 1Password CLI)
endif

	# see https://developer.1password.com/docs/cli/reference/commands/run
	op \
		run \
			--account="$(OP_ACCOUNT)" \
			--env-file="$(OP_ENV_FILE)" \
			-- \
			terraform \
				import \
					'$(local)' '$(remote)'
