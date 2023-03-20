# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team
resource "tfe_team" "owners" {
  name         = "owners"
  organization = var.tfe_organization_name
  visibility   = "organization"

  organization_access {
    manage_policies         = true
    manage_policy_overrides = true
    manage_workspaces       = true
    manage_vcs_settings     = true
    manage_providers        = true
    manage_modules          = false
    manage_run_tasks        = true
    manage_projects         = true
  }
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_member
resource "tfe_team_member" "owners" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for user in tfe_organization_membership.owners :
    user.username => user
  }

  team_id  = tfe_team.owners.id
  username = each.value.username
}

