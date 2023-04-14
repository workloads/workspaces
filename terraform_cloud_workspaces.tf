# may be imported like so: `terraform import tfe_workspace.dns workloads/dns`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "dns" {
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  assessments_enabled           = true
  auto_apply                    = var.tfe_workspace_auto_apply
  description                   = "DNS Configuration for `${var.project_identifier}`."
  execution_mode                = "remote"
  file_triggers_enabled         = true
  name                          = "dns"
  organization                  = tfe_organization.main.name
  project_id                    = tfe_project.management.id
  structured_run_output_enabled = true

  tag_names = [
    var.tags.exec_remote,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.service_gandi,
    var.tags.type_provision,
  ]

  terraform_version = var.tfe_workspace_terraform_version

  # TODO: re-enable when appropriate
  #  vcs_repo {
  #    branch         = "main"
  #    identifier     = local.repository_slugs.dns
  #    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  #  }
}

# may be imported like so: `terraform import tfe_workspace.networking workloads/networking`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "networking" {
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  assessments_enabled           = true
  auto_apply                    = var.tfe_workspace_auto_apply
  description                   = "Networking Configuration for `${var.project_identifier}`."
  execution_mode                = "remote"
  file_triggers_enabled         = true
  name                          = "networking"
  organization                  = tfe_organization.main.name
  project_id                    = tfe_project.management.id
  structured_run_output_enabled = true

  tag_names = [
    var.tags.exec_remote,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.type_provision,
  ]

  terraform_version = var.tfe_workspace_terraform_version

  # TODO: re-enable when appropriate
  #  vcs_repo {
  #    branch         = "main"
  #    identifier     = local.repository_slugs.networking
  #    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  #  }
}

# may be imported like so: `terraform import tfe_workspace.regional_workspaces workloads/regional_workspaces`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "regional_workspaces" {
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  assessments_enabled           = true
  auto_apply                    = var.tfe_workspace_auto_apply
  description                   = "Regional Workspaces Configuration for `${var.project_identifier}`."
  execution_mode                = "remote"
  file_triggers_enabled         = true
  name                          = "regional-workspaces"
  organization                  = tfe_organization.main.name
  project_id                    = tfe_project.management.id
  structured_run_output_enabled = true

  tag_names = [
    var.tags.exec_remote,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.type_provision,
  ]

  terraform_version = var.tfe_workspace_terraform_version

  # TODO: re-enable when appropriate
  #  vcs_repo {
  #    branch         = "main"
  #    identifier     = local.repository_slugs.networking
  #    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  #  }
}

# may be imported like so: `terraform import tfe_workspace.repositories workloads/repositories`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "repositories" {
  allow_destroy_plan    = var.tfe_workspace_allow_destroy_plan
  assessments_enabled   = true
  auto_apply            = var.tfe_workspace_auto_apply
  description           = "GitHub Configuration for `${var.project_identifier}`."
  execution_mode        = "remote"
  file_triggers_enabled = true
  name                  = "repositories"
  organization          = tfe_organization.main.name
  project_id            = tfe_project.management.id

  # `repositories` provides a list of GitHub Slugs as outputs that serve
  # as input for `vcs_repo` connections for other `tfe_workspace` resources.
  remote_state_consumer_ids = [
    tfe_workspace.workspaces.id
  ]

  structured_run_output_enabled = true

  tag_names = [
    var.tags.exec_remote,
    var.tags.region_global,
    var.tags.service_github,
    var.tags.type_provision,
  ]

  terraform_version = var.tfe_workspace_terraform_version

  # `repositories` is a special workspace, in that it cannot retrieve data from `data.tfe_outputs.repositories`
  # as this would cause a circular dependency; to account for this, `vcs_repo.identifier` has to be set manually
  #  vcs_repo {
  #    branch         = "main"
  #    identifier     = "workloads/github-organization"
  #    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  #  }
}

# may be imported like so: `terraform import tfe_workspace.services_configuration workloads/services-configuration`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "services_configuration" {
  name                          = "services-configuration"
  description                   = "Services Configuration for `${var.project_identifier}`."
  assessments_enabled           = true
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  execution_mode                = "remote"
  file_triggers_enabled         = true
  structured_run_output_enabled = true
  project_id                    = tfe_project.management.id
  organization                  = tfe_organization.main.name
  terraform_version             = var.tfe_workspace_terraform_version

  tag_names = [
    var.tags.exec_remote,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.type_secure,
  ]
}

# may be imported like so: `terraform import tfe_workspace.services_deployment workloads/services-deployment`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "services_deployment" {
  assessments_enabled           = true
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  description                   = "Services Deployment for `${var.project_identifier}`."
  execution_mode                = "remote"
  file_triggers_enabled         = true
  name                          = "services-deployment"
  organization                  = tfe_organization.main.name
  structured_run_output_enabled = true

  tag_names = [
    var.tags.exec_remote,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.type_secure,
  ]

  terraform_version = var.tfe_workspace_terraform_version

  # TODO: re-enable when appropriate
  #  vcs_repo {
  #    branch         = "main"
  #    identifier     = local.repository_slugs["services-deployment"]
  #    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  #  }
}

# may be imported like so: `terraform import tfe_workspace.website workloads/users`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "users" {
  assessments_enabled           = true
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  execution_mode                = "remote"
  file_triggers_enabled         = true
  description                   = "User Directory Management for `${var.project_identifier}`."
  name                          = "users"
  organization                  = tfe_organization.main.name
  structured_run_output_enabled = true

  tag_names = [
    var.tags.exec_remote,
    var.tags.region_global,
    var.tags.service_okta,
    var.tags.type_provision,
    var.tags.type_secure,
  ]

  terraform_version = var.tfe_workspace_terraform_version

  # TODO: re-enable when appropriate
  #  vcs_repo {
  #    branch         = "main"
  #    identifier     = local.repository_slugs.website
  #    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  #  }
}

# may be imported like so: `terraform import tfe_workspace.website workloads/website`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "website" {
  assessments_enabled           = true
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  execution_mode                = "local"
  file_triggers_enabled         = true
  description                   = "Website for `${var.project_identifier}`."
  name                          = "website"
  organization                  = tfe_organization.main.name
  structured_run_output_enabled = true

  tag_names = [
    var.tags.exec_local,
    "${var.tags.region_prefix}:${var.management_region_aws}",
    var.tags.service_aws,
    var.tags.service_github,
    var.tags.type_provision,
    var.tags.type_run,
  ]

  terraform_version = var.tfe_workspace_terraform_version

  # TODO: re-enable when appropriate
  #  vcs_repo {
  #    branch         = "main"
  #    identifier     = local.repository_slugs.website
  #    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  #  }
}

# may be imported like so: `terraform import tfe_workspace.workspaces workloads/workspaces`
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "workspaces" {
  #assessments_enabled           = false # explicitly disabled because of reasons
  allow_destroy_plan            = var.tfe_workspace_allow_destroy_plan
  auto_apply                    = var.tfe_workspace_auto_apply
  execution_mode                = "local"
  description                   = "Terraform Cloud Configuration for `${var.project_identifier}`."
  file_triggers_enabled         = false
  name                          = "workspaces"
  organization                  = tfe_organization.main.name
  structured_run_output_enabled = true

  tag_names = [
    var.tags.exec_local,
    var.tags.region_global,
    var.tags.type_seed,
  ]

  terraform_version = var.tfe_workspace_terraform_version
}
