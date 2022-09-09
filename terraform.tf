terraform {
  # see https://www.terraform.io/language/settings/terraform-cloud
  cloud {
    # see https://www.terraform.io/cli/cloud/settings#organization
    organization = "workloads"

    # see https://www.terraform.io/cli/cloud/settings#workspaces
    workspaces {
      name = "workspaces"
    }
  }

  # see https://www.terraform.io/docs/language/settings/index.html#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/integrations/github/4.31.0/
    github = {
      source  = "integrations/github"
      version = ">= 4.31.0, < 5.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/tfe/0.36.1/
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.36.1, < 1.0.0"
    }
  }

  # see https://www.terraform.io/docs/language/settings/index.html#specifying-a-required-terraform-version
  required_version = ">= 1.2.9"
}
