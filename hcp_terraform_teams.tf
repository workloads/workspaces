# The `owners` team is a pre-existing resource and must be imported before it can be used through the `tfe` provider.
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team
resource "tfe_team" "owners" {
  name         = "owners"
  organization = var.tfe_organization_name

  # owners are generally kept secret as they present an attack vector
  # (this setting is made, despite the code repository itself being public)
  visibility = "secret"

  # see https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/permissions#organization-permissions
  organization_access {
    access_secret_teams = true

    manage_agent_pools         = true
    manage_membership          = true
    manage_organization_access = true
    manage_policies            = true
    manage_policy_overrides    = true
    manage_teams               = true
    manage_workspaces          = true
    manage_vcs_settings        = true
    manage_providers           = true
    manage_modules             = true
    manage_run_tasks           = true
    manage_projects            = true

    read_projects   = true
    read_workspaces = true
  }
}

# The `owners` team is a pre-existing resource and must be imported before it can be used through the `tfe` provider.
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team
resource "tfe_team" "viewers" {
  name         = "viewers"
  organization = var.tfe_organization_name
  visibility   = "organization"

  # see https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/permissions#organization-permissions
  organization_access {
    manage_policies         = false
    manage_policy_overrides = false
    manage_workspaces       = false
    manage_vcs_settings     = false
    manage_providers        = false
    manage_modules          = false
    manage_run_tasks        = false
    manage_projects         = false

    read_projects   = true
    read_workspaces = true
  }
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_membership
resource "tfe_organization_membership" "owners" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = toset(var.tfe_organization_owner_humans)

  email        = each.key
  organization = tfe_organization.main.name
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_organization_member
resource "tfe_team_organization_member" "owners" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    # see https://developer.hashicorp.com/terraform/language/expressions/for
    for membership in tfe_organization_membership.owners : membership.email => membership
  }

  team_id = tfe_team.owners.id
  organization_membership_id = each.value.id
}
