# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/oauth_client
data "tfe_oauth_client" "client" {
  oauth_client_id = var.tfe_oauth_client_id
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/outputs
data "tfe_outputs" "repositories" {
  organization = tfe_organization.main.name
  workspace    = tfe_workspace.repositories.name
}

locals {
  # map outputs from `repositories` HCP Terraform Workspace for easier usage:
  repository_slugs = data.tfe_outputs.repositories.values.github_repository_slugs
}
