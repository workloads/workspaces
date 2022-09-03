module "datadog_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "datadog"
  description  = "Datadog-specific Variables. See https://app.datadoghq.com/organization-settings/api-keys for more information."
  organization = tfe_organization.main.name

  workspace_ids = [
    # needed for HCP Vault Audit and Metrics Logging
    tfe_workspace.services_deployment.id
  ]

  variables = local.datadog_configuration
}

module "gandi_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "gandi"
  description  = "Gandi-specific Variables. See https://account.gandi.net/en/users/${var.project_identifier}/security for more information."
  organization = tfe_organization.main.name

  workspace_ids = [
    tfe_workspace.dns.id
  ]

  variables = local.gandi_configuration
}

module "github_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "github"
  description  = "GitHub-specific Variables."
  organization = tfe_organization.main.name

  workspace_ids = [
    # needed for GitHub Organization management
    tfe_workspace.repositories.id,

    # needed for GitHub API data retrieval
    tfe_workspace.website.id,
  ]

  variables = local.github_configuration
}

module "project_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name          = "project"
  description   = "Project-specific Variables."
  global        = true
  organization  = tfe_organization.main.name
  workspace_ids = []
  variables     = local.project_configuration
}

# assign TFE Organization Token to Terraform Cloud Workspaces that require access to it.
module "terraform_cloud_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "Terraform Cloud Token"
  description  = "Terraform Cloud API Token."
  organization = tfe_organization.main.name

  workspace_ids = [
    tfe_workspace.networking.id,
    #tfe_workspace.services_deployment.id,
  ]

  variables = [
    {
      key         = "TFE_TOKEN"
      category    = "env"
      value       = tfe_organization_token.organization.token
      description = "Terraform Cloud Organization Token."
      sensitive   = true
  }]
}

module "variable_set_hcp_credentials_contributor" {
  # TODO: update to Registry URL
  source = "git@github.com:ksatirli/terraform-tfe-variable-set-hcp-credentials.git?ref=adds-code"

  credentials = {
    client_id     = var.hcp_contributor_id
    client_secret = var.hcp_contributor_secret
  }

  organization = tfe_organization.main.name
  type         = "contributor"

  workspace_ids = [
    tfe_workspace.workspaces.id,
    tfe_workspace.networking.id,
    tfe_workspace.services_deployment.id,
    #tfe_workspace.services_configuration.id,
  ]
}

module "variable_set_hcp_credentials_viewer" {
  # TODO: update to Registry URL
  source = "git@github.com:ksatirli/terraform-tfe-variable-set-hcp-credentials.git?ref=adds-code"

  credentials = {
    client_id     = var.hcp_viewer_id
    client_secret = var.hcp_viewer_secret
  }

  organization = tfe_organization.main.name
  type         = "viewer"

  workspace_ids = [
    #tfe_workspace.services_configuration.id,
  ]
}
