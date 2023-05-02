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

COLOR_OFF    = $(shell tput sgr0)
COLOR_BRIGHT = $(shell tput bold)
OP_ACCOUNT   = workloads.1password.com
OP_ENV_FILE  = terraform.op.env
ARGS         =

define missing_command
	$(error Missing command for `terraform`. Specify with `make terraform command=plan`)
endef

.SILENT .PHONY: help
help: # Displays a list of all Make Targets
	$(info )
	$(info $(COLOR_BRIGHT)TERRAFORM SEED WORKSPACE$(COLOR_OFF))
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
print-secrets: # Prints sanitized environment variables (requires the `envo` CLI application)
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
terraform: # Injects secrets from 1Password into a `terraform` {plan, apply, destroy, etc.} run
# see https://developer.1password.com/docs/cli/reference/commands/run
	$(if $(command),,$(call missing_command))

	op \
		run \
			--account="$(OP_ACCOUNT)" \
			--env-file="$(OP_ENV_FILE)" \
			-- \
			terraform $(command) $(ARGS)

.SILENT .PHONY: import
import: # Injects secrets from 1Password into a `terraform` {plan, apply, destroy, etc.} run
# see https://developer.1password.com/docs/cli/reference/commands/run
	op \
		run \
			--account="$(OP_ACCOUNT)" \
			--env-file="$(OP_ENV_FILE)" \
			-- \
			terraform import '<Terraform Resource Identifier>' '<Remote API identifier>'
