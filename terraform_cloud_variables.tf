module "aws_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "AWS-specific Variables."
  name         = "AWS"
  organization = tfe_organization.main.name

  variables = local.aws_variables

  workspace_ids = [
    tfe_workspace.dns.id,
    tfe_workspace.networking.id,
  ]

}

module "datadog_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "Datadog-specific Variables. See https://app.datadoghq.com/organization-settings/api-keys for more information."
  name         = "Datadog"
  organization = tfe_organization.main.name

  variables = local.datadog_variables

  workspace_ids = [
    # needed for HCP Vault Audit and Metrics Logging
    tfe_workspace.services_deployment.id
  ]
}

module "gandi_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "Gandi-specific Variables. See https://account.gandi.net/en/users/${var.project_identifier}/security for more information."
  name         = "Gandi.net"
  organization = tfe_organization.main.name

  variables = local.gandi_variables

  workspace_ids = [
    tfe_workspace.dns.id
  ]
}

module "github_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "GitHub-specific Variables."
  name         = "GitHub (Org: `${var.github_owner}`)"
  organization = tfe_organization.main.name

  variables = local.github_variables

  workspace_ids = [
    # needed for GitHub Organization management
    tfe_workspace.repositories.id,

    # needed for GitHub API data retrieval
    tfe_workspace.website.id,
  ]
}

module "hcp_boundary_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "HCP Boundary-specific Variables."
  name         = "Boundary"
  organization = tfe_organization.main.name

  variables = local.hcp_boundary_variables

  workspace_ids = [
    tfe_workspace.services_deployment.id,
  ]
}

module "hcp_network_ids" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "HashiCorp Cloud Platform Network IDs."
  name         = "HashiCorp Cloud Platform Network IDs"
  organization = tfe_organization.main.name

  # empty set; Variable Set will be populated by `networking` Workspace
  variables = []

  workspace_ids = [
    # needed for HCP Vault deployment
    tfe_workspace.services_deployment.id,
  ]
}

module "hcp_contributor_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "HashiCorp Cloud Platform-specific Variables for `contributor` users."
  name         = "HashiCorp Cloud Platform Credentials (type: `contributor`)"
  organization = tfe_organization.main.name

  variables = local.hcp_contributor_variables

  workspace_ids = [
    tfe_workspace.workspaces.id,
    tfe_workspace.networking.id,
    tfe_workspace.services_deployment.id,
    #tfe_workspace.services_configuration.id,
  ]
}

module "hcp_viewer_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "HashiCorp Cloud Platform-specific Variables for `viewer` users."
  name         = "HashiCorp Cloud Platform Credentials (type: `viewer`)"
  organization = tfe_organization.main.name

  variables = local.hcp_viewer_variables

  workspace_ids = [
    # needed for HCP Vault configuration
    #tfe_workspace.services_configuration.id,
  ]
}

module "project_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "Project-specific Variables."
  name         = "Project"
  organization = tfe_organization.main.name

  variables = local.project_variables

  workspace_ids = [
    tfe_workspace.dns.id,
    tfe_workspace.networking.id,
    tfe_workspace.services_deployment.id,
  ]
}

module "terraform_cloud_oauth_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "Terraform Cloud-specific OAuth Variables."
  name         = "Terraform Cloud OAuth"
  organization = tfe_organization.main.name

  variables = local.tfe_oauth_variables

  workspace_ids = [
    tfe_workspace.regional_workspaces.id
  ]
}

# assign TFE Organization Token to Terraform Cloud Workspaces that require access to it.
module "terraform_cloud_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "Terraform Cloud API Token."
  name         = "Terraform Cloud"
  organization = tfe_organization.main.name

  variables = [
    {
      key         = "tfe_organization"
      category    = "terraform"
      value       = tfe_organization.main.name
      description = "Terraform Cloud Organization Name."
      sensitive   = false
    },
    {
      key         = "TFE_TOKEN"
      category    = "env"
      value       = tfe_organization_token.organization.token
      description = "Terraform Cloud Organization Token."
      sensitive   = true
  }]

  workspace_ids = [
    tfe_workspace.networking.id,
    tfe_workspace.regional_workspaces.id,
    #tfe_workspace.services_deployment.id,
  ]
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "regional_workspaces_terraform_version" {
  key          = "terraform_version"
  value        = var.tfe_workspace_terraform_version
  category     = "terraform"
  description  = "Terraform version to use for Regional Workspaces."
  workspace_id = tfe_workspace.regional_workspaces.id
}
