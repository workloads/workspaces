# Makefile for Terraform Cloud Workspaces Seeding

# see https://www.gnu.org/software/make/manual/html_node/Options_002fRecursion.html
MAKEFLAGS      = --no-builtin-rules --silent --warn-undefined-variables

# see https://www.gnu.org/software/make/manual/html_node/Choosing-the-Shell.html
SHELL         := sh
.SHELLFLAGS   := -eu -c

# see https://www.gnu.org/software/make/manual/html_node/Goals.html
.DEFAULT_GOAL := help

# see https://www.gnu.org/software/make/manual/html_node/One-Shell.html
.ONESHELL     :

OP_ACCOUNT   = workloads.1password.com
OP_ENV_FILE  = terraform.op.env
ARGS         =

define missing_command
	$(error Missing command for `terraform`. Specify with `make terraform command=plan`)
endef

.SILENT .PHONY: help
help: # display a list of Make Targets                     Usage: `make` or `make help`
	$(info )
	$(info $(shell tput bold)TERRAFORM WORKSPACES SEEDER$(shell tput sgr0))
	$(info )

	grep \
		--context=0 \
		--devices=skip \
		--extended-regexp \
		--no-filename \
			"(^[a-z-]+):{1} ?(?:[a-z-])* #" $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1m%s\033[0m;%s\n", $$1, $$2}' | \
	column \
		-c2 \
		-s ";" \
		-t
	$(info )

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
terraform: # execute `terraform` with a specific command        Usage `make terraform command=<plan, apply>`
	$(if $(command),,$(call missing_command))

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
