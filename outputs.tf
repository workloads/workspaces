locals {
  base_url = "https://app.terraform.io/app/${tfe_organization.main.name}"
}

output "variable_set_urls" {
  description = "Variable Set URLs."

  value = [
    "${local.base_url}/settings/varsets/${module.aws_variables.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.datadog_variables.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.gandi_variables.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.github_variables.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.hcp_network_ids.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.hcp_contributor_variables.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.hcp_viewer_variables.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.project_variables.tfe_variable_set.id}",
    "${local.base_url}/settings/varsets/${module.terraform_cloud_variables.tfe_variable_set.id}",
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

