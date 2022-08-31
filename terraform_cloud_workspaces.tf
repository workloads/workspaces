# may be imported like so: `terraform import tfe_workspace.dns workloads/dns`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "dns" {
  name                          = "dns"
  organization                  = tfe_organization.main.name
  description                   = "DNS Configuration for ${var.project_identifier}"
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  execution_mode                = "remote"
  file_triggers_enabled         = true
  structured_run_output_enabled = true
  terraform_version             = var.tfe_workspace_terraform_version

  tag_names = [
    var.tags.exec_remote,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.service_gandi,
    var.tags.type_provision,
  ]

  vcs_repo {
    branch         = "main"
    identifier     = local.repository_slugs.dns
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

# may be imported like so: `terraform import tfe_workspace.networking workloads/networking`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "networking" {
  name                          = "networking"
  organization                  = tfe_organization.main.name
  description                   = "Networking Configuration for ${var.project_identifier}"
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  execution_mode                = "remote"
  file_triggers_enabled         = true
  structured_run_output_enabled = true
  terraform_version             = var.tfe_workspace_terraform_version

  tag_names = [
    var.tags.exec_remote,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.type_provision,
  ]

  vcs_repo {
    branch         = "main"
    identifier     = local.repository_slugs.networking
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

# may be imported like so: `terraform import tfe_workspace.repositories workloads/repositories`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "repositories" {
  name                  = "repositories"
  organization          = tfe_organization.main.name
  description           = "GitHub Configuration for ${var.project_identifier}"
  allow_destroy_plan    = var.tfe_workspace_allow_destroy_plan
  auto_apply            = var.tfe_workspace_auto_apply
  execution_mode        = "remote"
  file_triggers_enabled = true

  # `repositories` provides a list of GitHub Slugs as outputs that serve
  # as input for `vcs_repo` connections for other `tfe_workspace` resources.
  remote_state_consumer_ids = [
    tfe_workspace.workspaces.id
  ]

  structured_run_output_enabled = true
  terraform_version             = var.tfe_workspace_terraform_version

  tag_names = [
    var.tags.exec_remote,
    var.tags.region_global,
    var.tags.service_github,
    var.tags.type_provision,
  ]

  # `repositories` is a special workspace, in that it cannot retrieve data from `data.tfe_outputs.repositories`
  # as this would cause a circular dependency; to account for this, `vcs_repo.identifier` has to be set manually
 vcs_repo {
   branch = "main"
   identifier         = "workloads/github-organization"
   oauth_token_id     = data.tfe_oauth_client.client.oauth_token_id
 }
}

## may be imported like so: `terraform import tfe_workspace.services_configuration workloads/services-configuration`
## see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
#resource "tfe_workspace" "services_configuration" {
#  name                          = "services-configuration"
#  organization                  = tfe_organization.main.name
#  description                   = "Services Configuration for ${var.project_identifier}"
#  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
#  auto_apply                    = var.tfe_workspace_auto_apply
#  execution_mode                = "remote"
#  file_triggers_enabled         = true
#  structured_run_output_enabled = true
#  terraform_version             = var.tfe_workspace_terraform_version
#
#  tag_names = [
#    var.tags.exec_remote,
#    "${var.tags.region_prefix}:${var.management_region_aws}",
#    var.tags.service_aws,
#    var.tags.type_secure,
#  ]
#
#  #    vcs_repo {
# branch = "main"
#  #      identifier         = var.tfe_workspace_vcs_repos.nomad_agents
#  #      oauth_token_id     = data.tfe_oauth_client.client.oauth_token_id
#  #    }
#}
#
# may be imported like so: `terraform import tfe_workspace.services_deployment workloads/services-deployment`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "services_deployment" {
  name                          = "services-deployment"
  organization                  = tfe_organization.main.name
  description                   = "Services Deployment for ${var.project_identifier}"
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  execution_mode                = "remote"
  structured_run_output_enabled = true
  terraform_version             = var.tfe_workspace_terraform_version

  tag_names = [
    var.tags.exec_remote,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.type_secure,
  ]

  vcs_repo {
    branch         = "main"
    identifier     = local.repository_slugs["services-deployment"]
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

# may be imported like so: `terraform import tfe_workspace.website workloads/website`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "website" {
  name                          = "website"
  organization                  = tfe_organization.main.name
  description                   = "Website for ${var.project_identifier}"
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  execution_mode                = "remote"
  file_triggers_enabled         = true
  structured_run_output_enabled = true
  terraform_version             = var.tfe_workspace_terraform_version

  tag_names = [
    var.tags.exec_remote,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.service_github,
    var.tags.type_provision,
    var.tags.type_run,
  ]

  vcs_repo {
    branch         = "main"
    identifier     = local.repository_slugs.website
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

# TODO: explicitly disable Drift Detection
# may be imported like so: `terraform import tfe_workspace.workspaces workloads/workspaces`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "workspaces" {
  name                          = "workspaces"
  organization                  = tfe_organization.main.name
  description                   = "Terraform Cloud Configuration for ${var.project_identifier}"
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  execution_mode                = "local"
  structured_run_output_enabled = true
  terraform_version             = var.tfe_workspace_terraform_version

  tag_names = [
    var.tags.exec_local,
    var.tags.region_global,
    var.tags.type_seed,
  ]
}
