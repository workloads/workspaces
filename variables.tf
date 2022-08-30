variable "github_owner" {
  type        = string
  description = "This is the target GitHub organization or individual user account to manage."
}

variable "github_token" {
  type        = string
  description = "A GitHub OAuth / Personal Access Token."
  sensitive   = true
}

# see https://cloud.hashicorp.com/docs/hcp/access-control/service-principals
variable "hcp_contributor_id" {
  type        = string
  description = "HashiCorp Cloud Platform ID for `contributor` Role."
  sensitive   = true
}

variable "hcp_contributor_secret" {
  type        = string
  description = "HashiCorp Cloud Platform Secret for `contributor` Role."
  sensitive   = true
}

# see https://cloud.hashicorp.com/docs/hcp/access-control/service-principals
variable "hcp_viewer_id" {
  type        = string
  description = "HashiCorp Cloud Platform ID for `viewer` Role."
  sensitive   = true
}

variable "hcp_viewer_secret" {
  type        = string
  description = "HashiCorp Cloud Platform Secret for `viewer` Role."
  sensitive   = true
}

variable "management_region_aws" {
  type        = string
  description = "AWS-specific `Management` Region Identifier."
  default     = "us-west-2"
}

variable "project_identifier" {
  type        = string
  description = "Human-readable Project Identifier."
  default     = "workloads"

  # `project_identifier` is widely used across this TFC Organization to identify
  # Terraform Cloud and HashiCorp Cloud Platform resources, so certain limits apply.
  validation {
    condition     = length(var.project_identifier) >= 3 && length(var.project_identifier) <= 36
    error_message = "`project_identifier` must be at least 3 and at most 36 characters."
  }

  # TODO: fix validation
  #  validation {
  #    condition = length(regexall("[., ]+", var.project_identifier)) != 0
  #    error_message = "`project_identifier` must not contain commas, periods, or spaces."
  #  }
}

variable "tags" {
  #  type = object({
  #
  #  })

  description = "Object containing pre-defined Tags."

  default = {
    # Terraform Cloud Execution Methods
    exec_agent  = "exec:agent"
    exec_local  = "exec:local"
    exec_remote = "exec:remote"

    # Infrastructure and Platform Providers
    service_aws     = "service:aws"
    service_azure   = "service:azure"
    service_gandi   = "service:gandi"
    service_gcp     = "service:googlecloud"
    service_github  = "service:github"
    service_datadog = "service:datadog"

    # Infrastructure Geo-Deployment Zones
    region_global = "region:global"
    region_prefix = "region"

    # Infrastructure Mission Objective(s)
    type_connect   = "type:connect"
    type_provision = "type:provision"
    type_run       = "type:run"
    type_secure    = "type:secure"
    type_seed      = "type:seed"
  }
}

variable "tfe_oauth_client_id" {
  type        = string
  description = "VCS Provider oAuth Client Identifier."
  sensitive   = true
}

variable "tfe_organization_email" {
  type        = string
  description = "Admin email address."
}

variable "tfe_organization_name" {
  type        = string
  description = "Name of the organization."
}

variable "tfe_organization_owners" {
  type        = list(string)
  description = "List of Email Addresses of Terraform Cloud Organization Owners."
  default = [
    "dstrickland@hashicorp.com",             # Derek Strickland
    "kerim@hashicorp.com",                   # Kerim Satirli
    "k.satirli+tfc-workloads-bot@gmail.com", # Service Account
  ]
}

variable "tfe_organization_token_force_regenerate" {
  type        = bool
  description = "Whether to forcefully regenerate and replace TFE Organization Token."
  default     = false
}

variable "tfe_workspace_allow_destroy_plan" {
  type        = bool
  description = "Whether destroy plans can be queued on the workspace."
  default     = false
}

variable "tfe_workspace_auto_apply" {
  type        = bool
  description = "Whether to automatically apply changes when a Terraform plan is successful."
  default     = true
}

variable "tfe_workspace_terraform_version" {
  type        = string
  description = "The version of Terraform to use for this workspace. "
  default     = "1.2.8"
}

variable "tfe_workspace_vcs_repos" {
  type        = map(string)
  description = "Map of VCS Repository Slugs."

  default = {
    nomad_agents = "ksatirli/tfc-demo"
  }
}

locals {
  # Project-specific Configuration Variables
  project_configuration = [
    {
      key         = "project_identifier"
      value       = var.project_identifier
      description = "Human-readable Project Identifier."
      }, {
      key         = "management_region_aws"
      value       = var.management_region_aws
      description = "AWS-specific Management Region Identifier."
      }, {
      key         = "tfe_organization"
      value       = tfe_organization.main.name
      description = "Terraform Cloud Organization Name."
    }
  ]

  # GitHub-specific Configuration Variables
  github_configuration = [
    {
      key         = "github_owner"
      value       = var.github_owner
      description = "GitHub Organization."
      sensitive   = false
      }, {
      key = "github_token"

      # ⚠️ Using `nonsensitive` on a sensitive value will persist the sensitive value in your Terraform State.
      # see https://www.terraform.io/language/functions/nonsensitive
      value       = nonsensitive(var.github_token)
      description = "GitHub Access Token."

      # ⚠️ Set value as sensitive (despite marking it as non-sensitive earlier). This ensures that the token
      # does not display directly in this Terraform Cloud Workspace's Variables section.
      sensitive = true
    }
  ]
}