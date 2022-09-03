locals {
  base_url = "https://app.terraform.io/app/${tfe_organization.main.name}"
}

output "variable_set_urls" {
  description = "Variable Set URLs."

  value = [
    "${local.base_url}/settings/varsets/${module.datadog_variable_set.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.gandi_variable_set.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.github_variable_set.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.project_variable_set.tfe_variable_set.id}",
    module.variable_set_hcp_credentials_contributor.variable_set_url,
    module.variable_set_hcp_credentials_viewer.variable_set_url
  ]
}

output "workspace_urls" {
  description = "Workspace URLs."

  value = [
    "${local.base_url}/workspaces/${tfe_workspace.dns.name}",
    "${local.base_url}/workspaces/${tfe_workspace.networking.name}",
    "${local.base_url}/workspaces/${tfe_workspace.repositories.name}",
    #"${local.base_url}/workspaces/${tfe_workspace.services_configuration.name}",
    "${local.base_url}/workspaces/${tfe_workspace.services_deployment.name}",
    "${local.base_url}/workspaces/${tfe_workspace.website.name}",
    "${local.base_url}/workspaces/${tfe_workspace.workspaces.name}",
  ]
}

output "github_urls" {
  description = "GitHub URLs."

  value = [
    "https://github.com/organizations/${var.github_owner}/settings/secrets/actions",
  ]
}

