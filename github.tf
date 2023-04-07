# set Snyk Organization Identifier as GitHub Organization Variable to allow
# for easier re-use and maintainability across GitHub Actions Workflows
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable
resource "github_actions_organization_variable" "snyk_org" {
  variable_name = "snyk_org"
  visibility    = "all"
  value         = var.snyk_org
}

# set Terraform core version as GitHub Organization Variable to allow
# for easier re-use and maintainability across GitHub Actions Workflows
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable
resource "github_actions_organization_variable" "terraform_version" {
  variable_name = "terraform_version"
  visibility    = "all"
  value         = var.tfe_workspace_terraform_version
}

# set Terraform Cloud Token as GitHub Organization Secret to allow for
# easier re-use and maintainability across GitHub Actions Workflows
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret
resource "github_actions_organization_secret" "terraform_cloud_token" {
  secret_name     = "TF_API_TOKEN"
  visibility      = "all"
  plaintext_value = tfe_organization_token.organization.token
}

# set Snyk Org Name and Auth Token as GitHub Organization Secret to allow
# for easier re-use and maintainability across GitHub Actions Workflows
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret
resource "github_actions_organization_secret" "snyk" {
  for_each = {
    for secret in local.snyk_action_secrets :
    secret.secret_name => secret
  }

  secret_name     = each.value.secret_name
  visibility      = "all"
  plaintext_value = each.value.plaintext_value
}
