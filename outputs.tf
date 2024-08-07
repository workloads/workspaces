locals {
  base_url = "https://app.terraform.io/app/${tfe_organization.main.name}"
}

output "variable_set_urls" {
  description = "Variable Set URLs."

  value = [
    {
      name = module.auth0_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.auth0_variables.tfe_variable_set.id}",
      }, {
      name = module.aws_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.aws_variables.tfe_variable_set.id}",
      }, {
      name = module.aws_administrator_credentials.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.aws_administrator_credentials.tfe_variable_set.id}",
      }, {
      name = module.azure_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.azure_variables.tfe_variable_set.id}",
      }, {
      name = module.datadog_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.datadog_variables.tfe_variable_set.id}",
      }, {
      name = module.discord_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.discord_variables.tfe_variable_set.id}",
      }, {
      name = module.docker_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.docker_variables.tfe_variable_set.id}",
      }, {
      name = module.gandi_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.gandi_variables.tfe_variable_set.id}",
      }, {
      name = module.gitguardian_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.gitguardian_variables.tfe_variable_set.id}",
      }, {
      name = module.github_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.github_variables.tfe_variable_set.id}",
      }, {
      name = module.google_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.google_variables.tfe_variable_set.id}",
      }, {
      name = module.hcp_boundary_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.hcp_boundary_variables.tfe_variable_set.id}",
      }, {
      name = module.hcp_network_ids.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.hcp_network_ids.tfe_variable_set.id}",
      }, {
      name = module.hcp_contributor_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.hcp_contributor_variables.tfe_variable_set.id}",
      }, {
      name = module.hcp_vault_aws_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.hcp_vault_aws_variables.tfe_variable_set.id}",
      }, {
      name = module.hcp_viewer_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.hcp_viewer_variables.tfe_variable_set.id}",
      }, {
      name = module.mondoo_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.mondoo_variables.tfe_variable_set.id}",
      }, {
      name = module.okta_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.okta_variables.tfe_variable_set.id}",
      }, {
      name = module.project_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.project_variables.tfe_variable_set.id}",
      }, {
      name = module.pagerduty_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.pagerduty_variables.tfe_variable_set.id}",
      }, {
      name = module.terraform_cloud_oauth_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.terraform_cloud_oauth_variables.tfe_variable_set.id}",
      }, {
      name = module.terraform_cloud_variables.tfe_variable_set.name,
      url  = "${local.base_url}/settings/varsets/${module.terraform_cloud_variables.tfe_variable_set.id}",
    }
  ]
}

output "workspace_urls" {
  description = "Workspace URLs."

  value = [
    "${local.base_url}/workspaces/${tfe_workspace.community.name}",
    "${local.base_url}/workspaces/${tfe_workspace.dns.name}",
    "${local.base_url}/workspaces/${tfe_workspace.networking.name}",
    "${local.base_url}/workspaces/${tfe_workspace.regional_workspaces.name}",
    "${local.base_url}/workspaces/${tfe_workspace.repositories.name}",
    "${local.base_url}/workspaces/${tfe_workspace.services_configuration.name}",
    "${local.base_url}/workspaces/${tfe_workspace.services_deployment.name}",
    "${local.base_url}/workspaces/${tfe_workspace.users.name}",
    "${local.base_url}/workspaces/${tfe_workspace.web_assets.name}",
    "${local.base_url}/workspaces/${tfe_workspace.web_assets_sync.name}",
    "${local.base_url}/workspaces/${tfe_workspace.web_redirects.name}",
    "${local.base_url}/workspaces/${tfe_workspace.website_deployment.name}",
    "${local.base_url}/workspaces/${tfe_workspace.workspaces.name}",
  ]
}

output "github_urls" {
  description = "GitHub URLs."

  value = [
    "https://github.com/organizations/${var.github_owner}/settings/secrets/actions",
  ]
}

output "tfe_workspace_terraform_version" {
  description = "Terraform version identifier of current HCP Terraform Workspace."
  value       = data.tfe_workspace.main.terraform_version
}
