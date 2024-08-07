# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization
resource "tfe_organization" "main" {
  assessments_enforced     = false # Assessments are set on a per-Workspace basis
  cost_estimation_enabled  = false # Cost estimation is handled via HCP Terraform Run Tasks
  collaborator_auth_policy = "two_factor_mandatory"
  email                    = var.tfe_organization_email
  name                     = var.tfe_organization_name
  session_remember_minutes = 20160 # 14 days
  session_timeout_minutes  = 10080 # 7 days
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_token
resource "tfe_organization_token" "organization" {
  force_regenerate = var.tfe_organization_token_force_regenerate
  organization     = tfe_organization.main.name
}
