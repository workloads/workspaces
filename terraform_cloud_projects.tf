# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project
resource "tfe_project" "management" {
  organization = var.tfe_organization_name
  name         = var.tfe_project_names.management
}

# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project
resource "tfe_project" "regional_workspaces" {
  organization = var.tfe_organization_name
  name         = var.tfe_project_names.regional
}
