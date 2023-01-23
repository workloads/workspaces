# Make configuration
MAKEFLAGS      = --no-builtin-rules --silent --warn-undefined-variables
SHELL         := sh

.DEFAULT_GOAL := help
.ONESHELL     :
.SHELLFLAGS   := -eu -c

color_off    = $(shell tput sgr0)
color_bright = $(shell tput bold)
op_account   = workloads.1password.com
op_env_file  = terraform.op.env
args         =

define missing_command
	$(error Missing command for `terraform`. Specify with `make terraform command=plan`)
endef

.SILENT .PHONY: help
help: # Displays this help text
	$(info )
	$(info $(color_bright)TERRAFORM SEED WORKSPACE$(color_off))
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
		  --account="$(op_account)" \
			--env-file="$(op_env_file)" \
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
			--account="$(op_account)" \
			--env-file="$(op_env_file)" \
			-- \
			terraform $(command) $(args)

.SILENT .PHONY: import
import: # Injects secrets from 1Password into a `terraform` {plan, apply, destroy, etc.} run
# see https://developer.1password.com/docs/cli/reference/commands/run
	op \
		run \
			--account="$(op_account)" \
			--env-file="$(op_env_file)" \
			-- \
			terraform import "<Terraform Resource Identifier>" "<Remote API identifier>"
