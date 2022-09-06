module "datadog_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "Datadog"
  description  = "Datadog-specific Variables. See https://app.datadoghq.com/organization-settings/api-keys for more information."
  organization = tfe_organization.main.name

  workspace_ids = [
    # needed for HCP Vault Audit and Metrics Logging
    tfe_workspace.services_deployment.id
  ]

  variables = local.datadog_variables
}

module "gandi_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "Gandi.net"
  description  = "Gandi-specific Variables. See https://account.gandi.net/en/users/${var.project_identifier}/security for more information."
  organization = tfe_organization.main.name

  workspace_ids = [
    tfe_workspace.dns.id
  ]

  variables = local.gandi_variables
}

module "github_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "GitHub (Org: `${var.github_owner}`)"
  description  = "GitHub-specific Variables."
  organization = tfe_organization.main.name

  workspace_ids = [
    # needed for GitHub Organization management
    tfe_workspace.repositories.id,

    # needed for GitHub API data retrieval
    tfe_workspace.website.id,
  ]

  variables = local.github_variables
}

module "hcp_contributor_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "HashiCorp Cloud Platform Credentials (type: `contributor`)"
  description  = "HashiCorp Cloud Platform-specific Variables for `contributor` users."
  organization = tfe_organization.main.name

  workspace_ids = [
    tfe_workspace.workspaces.id,
    tfe_workspace.networking.id,
    tfe_workspace.services_deployment.id,
    #tfe_workspace.services_configuration.id,
  ]

  variables = local.hcp_contributor_variables
}

module "hcp_viewer_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "HashiCorp Cloud Platform Credentials (type: `viewer`)"
  description  = "HashiCorp Cloud Platform-specific Variables for `viewer` users."
  organization = tfe_organization.main.name

  workspace_ids = [
    # needed for HCP Vault configuration
    #tfe_workspace.services_configuration.id,
  ]

  variables = local.hcp_viewer_variables
}

module "project_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name          = "Project"
  description   = "Project-specific Variables."
  global        = true
  organization  = tfe_organization.main.name
  workspace_ids = []
  variables     = local.project_variables
}

# assign TFE Organization Token to Terraform Cloud Workspaces that require access to it.
module "terraform_cloud_variables" {
  source = "github.com/ksatirli/terraform-tfe-variable-set?ref=adds-code"

  name         = "Terraform Cloud"
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
