# see https://registry.terraform.io/providers/auth0/auth0/latest/docs#client_id
variable "auth0_client_id" {
  type        = string
  description = "Auth0 Client ID."
}

# see https://registry.terraform.io/providers/auth0/auth0/latest/docs#client_secret
variable "auth0_client_secret" {
  type        = string
  description = "Auth0 Client Secret."
}

# see https://registry.terraform.io/providers/auth0/auth0/latest/docs#domain
variable "auth0_domain" {
  type        = string
  description = "Auth0 Domain Name."
}

variable "aws_directory_admin_username" {
  type        = string
  description = "AWS Directory Service Admin Username."
}

variable "aws_directory_admin_password" {
  type        = string
  description = "AWS Directory Service Admin Password."
  sensitive   = true
}

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

variable "discord_token" {
  type        = string
  description = "Discord API Token."
  sensitive   = true
}

variable "docker_username" {
  type        = string
  description = "Docker Hub Username."
  default     = "workloadsbot"
}

variable "docker_read_write_delete_token" {
  type        = string
  description = "Docker Hub Read / Write / Delete Token."
  sensitive   = true
}

variable "docker_read_write_token" {
  type        = string
  description = "Docker Hub Read / Write Token."
  sensitive   = true
}

variable "docker_read_token" {
  type        = string
  description = "Docker Hub Read Token."
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

variable "gitguardian_user" {
  type        = string
  description = "GitGuardian Service Account User."
  default     = "workloads-bot"
}

variable "gitguardian_token" {
  type        = string
  description = "GitGuardian Service Account Token."
  sensitive   = true
}

variable "github_owner" {
  type        = string
  description = "This is the target GitHub organization or individual user account to manage."
  default     = "workloads"
}

variable "github_token" {
  type        = string
  description = "A GitHub OAuth / Personal Access Token."
  sensitive   = true
}

variable "google_project_id" {
  type        = string
  description = "The Project ID to use for authenticating with GCP."
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

variable "management_region_gcp" {
  type        = string
  description = "Google-specific `Management` Region Identifier."
  default     = "us-central1"
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

variable "csp_configuration" {
  type = list(object({
    name    = string
    prefix  = string
    enabled = bool
  }))

  description = "Project-wide List of Cloud Service Providers (CSPs)."

  default = [
    {
      name    = "AWS Web Services"
      prefix  = "aws"
      enabled = true
      }, {
      name    = "Microsoft Azure"
      prefix  = "az"
      enabled = false
      }, {
      name    = "Digital Ocean"
      prefix  = "do"
      enabled = false
      }, {
      name    = "Google Cloud Platform"
      prefix  = "gcp"
      enabled = false
      }, {
      name    = "Scaleway"
      prefix  = "scw"
      enabled = false
    }
  ]
}

variable "mondoo_space_id" {
  type        = string
  description = "Mondoo Space Identifier."
}

variable "mondoo_credential" {
  type        = string
  description = "Mondoo Credential."
  sensitive   = true
}

variable "okta_org_name" {
  type        = string
  description = "Okta Organization Name."
}

variable "okta_api_token" {
  type        = string
  description = "Okta API Token."
  sensitive   = true
}

variable "pagerduty_key_readwrite" {
  type        = string
  description = "PagerDuty Read-Write Key."
  sensitive   = true
}

variable "pagerduty_key_read" {
  type        = string
  description = "PagerDuty Read-Only Key."
  sensitive   = true
}

variable "pagerduty_subdomain" {
  type        = string
  description = "PagerDuty Subdomain"
}

variable "snyk_org" {
  type        = string
  description = "Snyk Organization Name."
  default     = "workloads"
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
  type        = map(string)
  description = "Object containing pre-defined Tags."

  default = {
    # Terraform Cloud Execution Methods
    exec_agent  = "exec:agent"
    exec_local  = "exec:local"
    exec_remote = "exec:remote"

    # Infrastructure and Platform Providers
    service_aws     = "service:aws"
    service_azure   = "service:azure"
    service_datadog = "service:datadog"
    service_discord = "service:discord"
    service_do      = "service:digitalocean"
    service_gandi   = "service:gandi"
    service_gcp     = "service:gcp"
    service_github  = "service:github"
    service_okta    = "service:okta"
    service_snyk    = "service:snyk"

    # Infrastructure Geo-Deployment Zones
    region_global = "region:global"
    region_prefix = "region"

    # Infrastructure Mission Objectives
    type_connect   = "type:connect"
    type_provision = "type:provision"
    type_run       = "type:run"
    type_secure    = "type:secure"
    type_seed      = "type:seed"
  }
}

variable "tfe_oauth_client_id" {
  type        = string
  description = "VCS Provider OAuth Client Identifier."
  sensitive   = true
}

variable "tfe_organization_email" {
  type        = string
  description = "Admin email address."
}

variable "tfe_organization_name" {
  type        = string
  description = "Name of the organization."
  default     = "workloads"
}

variable "tfe_organization_owners" {
  type        = list(string)
  description = "List of Email Addresses of Terraform Cloud Organization Owners."

  default = [
    # TODO: import
    #"adrian.todorov@hashicorp.com", # Adrian Todorov / `atodorov-hashi`
    "justin.defrank@hashicorp.com", # Justin DeFrank / `rizkybiz`
    "kerim@hashicorp.com",          # Kerim Satirli / `ksatirli`
    "team@workloads.io",            # Service Account / `workloads-bot`
  ]
}

variable "tfe_organization_token_force_regenerate" {
  type        = bool
  description = "Whether to forcefully regenerate and replace TFE Organization Token."
  default     = false
}

variable "tfe_project_names" {
  type = object({
    auxiliary  = string
    management = string
  })

  description = "Object containing TFE Project Names."

  default = {
    auxiliary  = "Auxiliary"
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

  # see https://releases.hashicorp.com/terraform/
  default = "1.6.2"
}

locals {
  auth0_variables = [
    {
      key         = "auth0_client_id"
      category    = "terraform"
      value       = var.auth0_client_id
      description = "Auth0 Client ID."
      sensitive   = true
      }, {
      key         = "auth0_client_secret"
      category    = "terraform"
      value       = var.auth0_client_secret
      description = "Auth0 Client Secret."
      sensitive   = true
      }, {
      key         = "auth0_domain"
      category    = "terraform"
      value       = var.auth0_domain
      description = "Auth0 Domain Name."
      sensitive   = false
    },
  ]

  aws_variables = [
    {
      key         = "management_region_aws"
      category    = "terraform"
      value       = var.management_region_aws
      description = "AWS-specific Management Region Identifier."
      sensitive   = false
    },
  ]

  aws_directory_variables = [
    {
      key         = "aws_directory_username"
      category    = "terraform"
      value       = var.aws_directory_admin_username
      description = "AWS Directory Service Admin Username."
      sensitive   = false
    }, {
      key         = "aws_directory_password"
      category    = "terraform"
      value       = var.aws_directory_admin_password
      description = "AWS Directory Service Admin Password."
      sensitive   = true
    }
  ]

  azure_variables = [

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
    },
  ]

  digitalocean_variables = [

  ]

  discord_variables = [
    {
      key         = "discord_token"
      category    = "terraform"
      value       = var.discord_token
      description = "Discord API Token."
      sensitive   = true
    },
  ]

  docker_variables = [
    {
      key         = "docker_username"
      category    = "terraform"
      value       = var.docker_username
      description = "Docker Hub Username."
      sensitive   = false
    },
    {
      key         = "docker_read_write_delete_token"
      category    = "terraform"
      value       = var.docker_read_write_delete_token
      description = "Docker Hub Read / Write / Delete Token."
      sensitive   = true
    },
    {
      key         = "docker_read_write_token"
      category    = "terraform"
      value       = var.docker_read_write_token
      description = "Docker Hub Read / Write Token."
      sensitive   = true
    },
    {
      key         = "docker_read_token"
      category    = "terraform"
      value       = var.docker_read_token
      description = "Docker Hub Read Token."
      sensitive   = true
    },
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
    },
  ]

  gitguardian_variables = [
    {
      key         = "gitguardian_user"
      category    = "terraform"
      value       = var.gitguardian_user
      description = "GitGuardian Service Account User."
      sensitive   = false
      }, {
      key         = "gitguardian_token"
      category    = "terraform"
      value       = var.gitguardian_token
      description = "GitGuardian Service Account Token."
      sensitive   = true
    },
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
    },
  ]

  google_variables = [
    {
      key         = "google_project_id"
      category    = "terraform"
      value       = var.google_project_id
      description = "Google Cloud-specific Project ID."
      sensitive   = false
    },
    {
      key         = "management_region_gcp"
      category    = "terraform"
      value       = var.management_region_gcp
      description = "Google Cloud-specific Management Region Identifier."
      sensitive   = false
    },
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
    },
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
    },
  ]

  mondoo_variables = [
    {
      key         = "mondoo_space_id"
      category    = "terraform"
      value       = var.mondoo_space_id
      description = "Mondoo Space Identifier."
      sensitive   = false
    },
    {
      key         = "mondoo_credential"
      category    = "terraform"
      value       = var.mondoo_credential
      description = "Mondoo Credential."
      sensitive   = true
    },
    {
      key         = "docker_read_write_token"
      category    = "terraform"
      value       = var.docker_read_write_token
      description = "Docker Hub Read / Write Token."
      sensitive   = true
    },
    {
      key         = "docker_read_token"
      category    = "terraform"
      value       = var.docker_read_token
      description = "Docker Hub Read Token."
      sensitive   = true
    },
  ]

  okta_variables = [
    {
      key         = "okta_org_name"
      category    = "terraform"
      value       = var.okta_org_name
      description = "Okta Organization Name."
      sensitive   = false
    },
    {
      key         = "okta_api_token"
      category    = "terraform"
      value       = var.okta_api_token
      description = "Okta API Token."
      sensitive   = true
    },
  ]

  pagerduty_variables = [
    {
      key         = "pagerduty_key_rw"
      category    = "terraform"
      value       = var.pagerduty_key_readwrite
      description = "PagerDuty Read-Write Key."
      sensitive   = true
    },
    {
      key         = "pagerduty_key_ro"
      category    = "terraform"
      value       = var.pagerduty_key_read
      description = "PagerDuty Read-Only Key."
      sensitive   = true
    },
    {
      key         = "pagerduty_subdomain"
      category    = "terraform"
      value       = var.pagerduty_subdomain
      description = "PagerDuty Subdomain."
      sensitive   = false
    },
  ]

  project_variables = [
    {
      key         = "project_identifier"
      category    = "terraform"
      value       = var.project_identifier
      description = "Human-readable Project Identifier."
      sensitive   = false
    },
  ]

  snyk_action_secrets = [
    {
      secret_name     = "SNYK_TOKEN"
      visibility      = "all"
      plaintext_value = var.snyk_token
    },
  ]

  # Terraform Cloud-specific oAuth Variables for VCS Repository Connections
  tfe_oauth_variables = [
    {
      key         = "tfe_oauth_client_id"
      category    = "terraform"
      value       = data.tfe_oauth_client.client.oauth_token_id
      description = "Terraform Cloud OAuth Client Token ID."
      sensitive   = true
    },
  ]
}
