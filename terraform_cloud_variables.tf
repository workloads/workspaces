# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set
resource "tfe_variable_set" "project" {
  name         = "project"
  description  = "Project-specific Variables."
  global       = true
  organization = tfe_organization.main.name
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "project_configuration" {
  # see https://www.terraform.io/docs/language/meta-arguments/for_each.html
  for_each = {
    for item in local.project_configuration :
    item.key => item
  }

  key             = each.key
  value           = each.value.value
  category        = "terraform"
  description     = each.value.description
  variable_set_id = tfe_variable_set.project.id
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set
resource "tfe_workspace_variable_set" "github" {
  variable_set_id = tfe_variable_set.github.id
  workspace_id    = tfe_workspace.repositories.id
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set
resource "tfe_variable_set" "github" {
  name         = "github"
  description  = "GitHub-specific Variables."
  global       = false
  organization = tfe_organization.main.name
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "github_configuration" {
  # see https://www.terraform.io/docs/language/meta-arguments/for_each.html
  for_each = {
    for item in local.github_configuration :
    item.key => item
  }

  key             = each.key
  value           = each.value.value
  category        = "terraform"
  description     = each.value.description
  sensitive       = each.value.sensitive
  variable_set_id = tfe_variable_set.github.id
}

# assign TFE Organization Token to Terraform Cloud Workspaces that require access to it.
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "tfe_token" {
  for_each = toset([
    tfe_workspace.networking.id,
    #tfe_workspace.services_deployment.id,
  ])

  key          = "TFE_TOKEN"
  value        = tfe_organization_token.organization.token
  category     = "env"
  description  = "Terraform Cloud Organization Token."
  sensitive    = true
  workspace_id = each.key

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
    #tfe_workspace.services_deployment.id,
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
