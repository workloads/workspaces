# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs#api_key
variable "datadog_api_key" {
  type        = string
  description = "Datadog API Key."
  sensitive   = true
}

# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs#api_url
variable "datadog_api_url" {
  type        = string
  description = "Datadog API URL."
}

# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs#api_url
variable "datadog_api_zone" {
  type        = string
  description = "Datadog API Zone."
}

# see https://registry.terraform.io/providers/DataDog/datadog/latest/docs#app_key
variable "datadog_app_key" {
  type        = string
  description = "Datadog App Key."
  sensitive   = true
}

variable "gandi_key" {
  type        = string
  description = "This is the Gandi API Key."
}

variable "gandi_sharing_id" {
  type        = string
  description = "This is the Gandi Sharing ID."
}

variable "github_owner" {
  type        = string
  description = "This is the target GitHub organization or individual user account to manage."
}

variable "github_token" {
  type        = string
  description = "A GitHub OAuth / Personal Access Token."
  sensitive   = true
}

# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/boundary_cluster#username
variable "hcp_boundary_admin_username" {
  type        = string
  description = "HCP Boundary Cluster Admin Username."
}

# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/boundary_cluster#password
variable "hcp_boundary_admin_password" {
  type        = string
  description = "HCP Boundary Cluster Admin Password."
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

variable "infracost_org" {
  type        = string
  description = "Infracost Organization Identifier."
}

variable "infracost_runtask_hmac_key" {
  type        = string
  description = "HMAC Key for Infracost Run Task integration."
  sensitive   = true
}

variable "infracost_runtask_url" {
  type        = string
  description = "URL for Infracost Run Task integration."
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
    condition     = length(var.project_identifier) >= 3 && length(var.project_identifier) <= 24
    error_message = "`project_identifier` must be at least 3 and at most 24 characters."
  }

  validation {
    condition     = length(regexall("[., ]+", var.project_identifier)) == 0
    error_message = "`project_identifier` must not contain commas, periods, or spaces."
  }
}

variable "snyk_org" {
  type        = string
  description = "Snyk Organization Name."
}

variable "snyk_runtask_hmac_key" {
  type        = string
  description = "HMAC Key for Snyk Run Task integration."
  sensitive   = true
}

variable "snyk_runtask_url" {
  type        = string
  description = "URL for Snyk Run Task integration."
}

variable "snyk_token" {
  type        = string
  description = "Snyk API Auth Token."
  sensitive   = true
}

variable "tags" {
  type        = map(any)
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
    service_snyk    = "service:snyk"

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
    "kerim@hashicorp.com", # Kerim Satirli
    "team@workloads.io",   # Service Account
  ]
}

variable "tfe_organization_token_force_regenerate" {
  type        = bool
  description = "Whether to forcefully regenerate and replace TFE Organization Token."
  default     = false
}

variable "tfe_project_names" {
  type = object({
    management = string
  })

  description = "Object containing TFE Project Names."

  default = {
    management = "Management"
  }
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
  description = "Terraform version to use for this Workspace."
  default     = "1.3.7"
}

locals {
  aws_variables = [
    {
      key         = "management_region_aws"
      category    = "terraform"
      value       = var.management_region_aws
      description = "AWS-specific Management Region Identifier."
      sensitive   = false
    }
  ]

  datadog_variables = [
    {
      key         = "datadog_api_key"
      category    = "terraform"
      value       = var.datadog_api_key
      description = "Datadog API Key."
      sensitive   = true
      }, {
      key         = "datadog_api_url"
      category    = "terraform"
      value       = var.datadog_api_url
      description = "Datadog API URL."
      sensitive   = false
      }, {
      key         = "datadog_api_zone"
      category    = "terraform"
      value       = var.datadog_api_zone
      description = "Datadog API Zone."
      sensitive   = false
      }, {
      key         = "datadog_app_key"
      category    = "terraform"
      value       = var.datadog_app_key
      description = "Datadog App Key."
      sensitive   = true
    }
  ]

  gandi_variables = [
    {
      key         = "gandi_key"
      category    = "terraform"
      value       = var.gandi_key
      description = "Gandi API Key."
      sensitive   = true
      }, {
      key         = "gandi_sharing_id"
      category    = "terraform"
      value       = var.gandi_sharing_id
      description = "Gandi Sharing ID."
      sensitive   = true
    }
  ]

  github_variables = [
    {
      key         = "github_owner"
      category    = "terraform"
      value       = var.github_owner
      description = "GitHub Organization."
      sensitive   = false
      }, {
      key         = "github_token"
      category    = "terraform"
      value       = var.github_token
      description = "GitHub Access Token."
      sensitive   = true
    }
  ]

  # HCP Boundary-specific Configuration Variables for Cluster lifecycle management
  hcp_boundary_variables = [
    {
      key         = "hcp_boundary_admin_username"
      category    = "terraform"
      value       = var.hcp_boundary_admin_username
      description = "HCP Boundary Cluster Admin Username."
      sensitive   = false
      }, {
      key         = "hcp_boundary_admin_password"
      category    = "terraform"
      value       = var.hcp_boundary_admin_password
      description = "HCP Boundary Cluster Admin Password."
      sensitive   = true
    }
  ]

  # HCP-specific Configuration Variables for `contributor` users
  hcp_contributor_variables = [
    {
      key         = "HCP_CLIENT_ID"
      category    = "env"
      value       = var.hcp_contributor_id
      description = "OAuth2 Client ID for API operations."
      sensitive   = true
      }, {
      key         = "HCP_CLIENT_SECRET"
      category    = "env"
      value       = var.hcp_contributor_secret
      description = "OAuth2 Client Secret for API operations."
      sensitive   = true
    }
  ]

  # HCP-specific Configuration Variables for `viewer` users
  hcp_viewer_variables = [
    {
      key         = "HCP_CLIENT_ID"
      category    = "env"
      value       = var.hcp_viewer_id
      description = "OAuth2 Client ID for API operations."
      sensitive   = true
      }, {
      key         = "HCP_CLIENT_SECRET"
      category    = "env"
      value       = var.hcp_viewer_secret
      description = "OAuth2 Client Secret for API operations."
      sensitive   = true
    }
  ]

  project_variables = [
    {
      key         = "project_identifier"
      category    = "terraform"
      value       = var.project_identifier
      description = "Human-readable Project Identifier."
      sensitive   = false
    }
  ]

  snyk_action_secrets = [
    {
      secret_name     = "SNYK_ORG"
      visibility      = "all"
      plaintext_value = var.snyk_org
      }, {
      secret_name     = "SNYK_TOKEN"
      visibility      = "all"
      plaintext_value = var.snyk_token
    }
  ]

  # Terraform Cloud-specific oAuth Variables for VCS Repository Connections
  tfe_oauth_variables = [
    {
      key         = "tfe_oauth_client_id"
      category    = "terraform"
      value       = data.tfe_oauth_client.client.oauth_token_id
      description = "Terraform Cloud OAuth Client Token ID."
      sensitive   = true
    }
  ]
}
