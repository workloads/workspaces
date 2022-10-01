# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization
resource "tfe_organization" "main" {
  assessments_enforced     = false # Assessments are set on a per-Workspace basis
  collaborator_auth_policy = "two_factor_mandatory"
  email                    = var.tfe_organization_email
  name                     = var.tfe_organization_name
  session_remember_minutes = 10080
  session_timeout_minutes  = 10080
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_membership
resource "tfe_organization_membership" "owners" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = toset(var.tfe_organization_owners)

  email        = each.key
  organization = tfe_organization.main.name
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_token
resource "tfe_organization_token" "organization" {
  force_regenerate = var.tfe_organization_token_force_regenerate
  organization     = tfe_organization.main.name
}
