# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization
resource "tfe_organization" "main" {
  name                     = var.tfe_organization_name
  email                    = var.tfe_organization_email
  collaborator_auth_policy = "two_factor_mandatory"
  session_remember_minutes = 10080
  session_timeout_minutes  = 10080
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_membership
resource "tfe_organization_membership" "owners" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = toset(var.tfe_organization_owners)

  organization = tfe_organization.main.name
  email        = each.key
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_token
resource "tfe_organization_token" "organization" {
  organization     = tfe_organization.main.name
  force_regenerate = var.tfe_organization_token_force_regenerate
}
