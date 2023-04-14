module "aws_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "AWS-specific Variables."
  name         = "AWS"
  organization = tfe_organization.main.name

  variables = local.aws_variables

  workspace_ids = [
    # needed for Route 53 configuration
    tfe_workspace.dns.id,

    # needed for VPC and HVN configuration
    tfe_workspace.networking.id,

    # needed for Regional Workspace deployments
    tfe_workspace.regional_workspaces.id,
  ]
}

module "auth0_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "Auth0-specific Variables. See https://manage.auth0.com/dashboard/ for more information."
  name         = "Auth0"
  organization = tfe_organization.main.name

  variables = local.auth0_variables

  workspace_ids = [
    # needed for Auth0 Configuration
    tfe_workspace.services_configuration.id,
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
    tfe_workspace.services_deployment.id,
  ]
}

module "gandi_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "Gandi-specific Variables. See https://account.gandi.net/en/users/${tfe_organization.main.name}/security for more information."
  name         = "Gandi.net"
  organization = tfe_organization.main.name

  variables = local.gandi_variables

  workspace_ids = [
    # needed for DNS NS configuration
    tfe_workspace.dns.id,
  ]
}

module "github_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "GitHub-specific Variables. See https://github.com/${var.github_owner}."
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

  description  = "HCP Boundary-specific Variables. See https://portal.cloud.hashicorp.com/services/boundary/clusters/list for more information."
  name         = "Boundary"
  organization = tfe_organization.main.name

  variables = local.hcp_boundary_variables

  workspace_ids = [
    # needed for HCP Boundary and Vault configuration
    tfe_workspace.services_configuration.id,

    # needed for HCP Boundary and Vault deployment
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
    # needed for HCP Boundary and Vault deployment
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

    # needed for HVN provisioning
    tfe_workspace.networking.id,

    # needed for HCP Boundary and Vault configuration
    tfe_workspace.services_configuration.id,

    # needed for HCP Boundary and Vault deployment
    tfe_workspace.services_deployment.id,
  ]
}

module "hcp_vault_aws_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "HCP Vault-specific Variables. See https://portal.cloud.hashicorp.com/services/vault/clusters for more information."
  name         = "Vault"
  organization = tfe_organization.main.name

  # this value is set in `workloads/services-deployment` as it is not yet known
  variables = []

  workspace_ids = [
    # needed for HCP Vault configuration
    tfe_workspace.services_configuration.id,
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

  workspace_ids = []
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
    tfe_workspace.services_configuration.id,
    tfe_workspace.services_deployment.id,
  ]
}

module "okta_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "Okta-specific Variables."
  name         = "Okta"
  organization = tfe_organization.main.name

  variables = local.okta_variables

  workspace_ids = [
    # needed for Okta configuration
    tfe_workspace.users.id,
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
    # needed for Terraform Cloud VCS Repository configuration
    tfe_workspace.regional_workspaces.id,
  ]
}

# assign TFE Organization Token to Terraform Cloud Workspaces that require access to it.
module "terraform_cloud_variables" {
  # see https://registry.terraform.io/modules/ksatirli/variable-set/tfe/latest
  source  = "ksatirli/variable-set/tfe"
  version = "1.0.0"

  description  = "Terraform Cloud API Token. See https://app.terraform.io/app/${tfe_organization.main.name}/settings/authentication-tokens"
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
    # needed for HCP HVN configuration
    tfe_workspace.networking.id,

    # needed for Regional Workspace lifecycle management
    tfe_workspace.regional_workspaces.id,

    # needed for updating of Terraform Cloud Variable Sets
    tfe_workspace.services_deployment.id,
  ]
}

# set Regional Workspaces-specific version of Terraform
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "regional_workspaces_terraform_version" {
  key          = "terraform_version"
  value        = var.tfe_workspace_terraform_version
  category     = "terraform"
  description  = "Terraform version to use for Regional Workspaces."
  workspace_id = tfe_workspace.regional_workspaces.id
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set
resource "tfe_variable_set" "csp_configuration" {
  name         = "Cloud Service Providers"
  description  = "Cloud Service Providers (CSP) Configuration."
  organization = tfe_organization.main.name
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set
resource "tfe_workspace_variable_set" "csp_configuration" {
  for_each = toset([
    # needed for HCP Boundary Projects
    tfe_workspace.services_configuration.id,

    # needed for CSP configuration
    tfe_workspace.regional_workspaces.id,
  ])

  variable_set_id = tfe_variable_set.csp_configuration.id
  workspace_id    = each.key
}

# add CSP data  Workspaces-specific version of Terraform
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "csp_configuration" {
  key             = "csp_configuration"
  value           = jsonencode(var.csp_configuration)
  category        = "terraform"
  description     = "Project-wide List of Cloud Service Providers (CSPs)."
  sensitive       = false
  variable_set_id = tfe_variable_set.csp_configuration.id
}
