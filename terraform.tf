terraform {
  # see https://developer.hashicorp.com/terraform/language/settings/terraform-cloud
  cloud {
    # see https://app.terraform.io/app/workloads/workspaces
    # and https://developer.hashicorp.com/terraform/cli/cloud/settings#organization
    organization = "workloads"

    # see https://app.terraform.io/app/workloads/workspaces
    # and https://developer.hashicorp.com/terraform/cli/cloud/settings#workspaces
    workspaces {
      name = "workspaces"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/integrations/github/5.42.0
    github = {
      source  = "integrations/github"
      version = ">= 5.42.0, < 6.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/tfe/0.50.0
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.50.0, < 1.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.6.0, < 2.0.0"
}
