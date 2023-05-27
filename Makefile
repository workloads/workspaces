# Makefile for Terraform Cloud Workspaces Seeding

include ../tooling/make/configs/shared.mk

include ../tooling/make/functions/shared.mk

# configuration
TITLE        = 🟣 TERRAFORM CLOUD WORKSPACES
OP_ENV_FILE  = terraform.op.env
ARGS         =

# include Terraform-generated configuration data
include ../assets/scripts/_config.mk

include ../tooling/make/functions/maintenance.mk

include ../tooling/make/targets/shared.mk

.SILENT .PHONY: print-secrets
print-secrets: # print (sanitized) environment variables            Usage: `make print-secrets`
	# see https://developer.1password.com/docs/cli/reference/commands/run
	op \
		run \
		  --account="$(OP_ACCOUNT)" \
			--env-file="$(OP_ENV_FILE)" \
			--no-masking \
			-- \
			envo --truncLength=3 | \
			grep "TF_VAR_"

.SILENT .PHONY: terraform
terraform: # execute `terraform` with a specific command [Usage: `make terraform command=<plan, apply>`]
	$(if $(command),,$(call missing_subcommand,terraform,command=init))

	# see https://developer.1password.com/docs/cli/reference/commands/run
	op \
		run \
			--account="$(OP_ACCOUNT)" \
			--env-file="$(OP_ENV_FILE)" \
			-- \
			terraform $(command) $(ARGS)

.SILENT .PHONY: import
import: # execute `terraform import`                         Usage `make import`
	# see https://developer.1password.com/docs/cli/reference/commands/run
	op \
		run \
			--account="$(OP_ACCOUNT)" \
			--env-file="$(OP_ENV_FILE)" \
			-- \
			terraform import '<Terraform Resource Identifier>' '<Remote API identifier>'
