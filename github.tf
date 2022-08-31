# set Terraform version as GitHub Organization Secret to allow for
# easier re-use and maintainability across GitHub Actions Workflows
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret
resource "github_actions_organization_secret" "terraform_version" {
  secret_name     = "terraform_version"
  visibility      = "all"
  plaintext_value = var.tfe_workspace_terraform_version
}

# set Terraform Cloud Token as GitHub Organization Secret to allow for
# easier re-use and maintainability across GitHub Actions Workflows
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret
resource "github_actions_organization_secret" "terraform_cloud_token" {
  secret_name     = "TF_API_TOKEN"
  visibility      = "all"
  plaintext_value = tfe_organization_token.organization.token
}
