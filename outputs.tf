output "variable_set_urls" {
  description = "Variable Set URLs."

  value = [
    "https://app.terraform.io/app/${tfe_organization.main.name}/settings/varsets/${tfe_variable_set.project.id}",
    module.variable_set_hcp_credentials_contributor.variable_set_url,
    module.variable_set_hcp_credentials_viewer.variable_set_url
  ]
}

locals {
  base_url = "https://app.terraform.io/app/${tfe_organization.main.name}"
}

output "workspace_urls" {
  description = "Workspace URLs."

  value = [
    "${local.base_url}/workspaces/${tfe_workspace.workspaces.name}",
    "${local.base_url}/workspaces/${tfe_workspace.networking.name}",
    #"${local.base_url}/workspaces/${tfe_workspace.services_deployment.name}",
    #"${local.base_url}/workspaces/${tfe_workspace.services_configuration.name}",
  ]
}

output "github_urls" {
  description = "GitHub URLs."

  value = [
    "https://github.com/organizations/${var.github_owner}/settings/secrets/actions",
  ]
}

