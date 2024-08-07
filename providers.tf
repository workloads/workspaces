# see https://registry.terraform.io/providers/integrations/github/latest/docs
provider "github" {
  owner = var.github_owner
  token = var.github_token
}

# The HCP Terraform Provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs#authentication
provider "tfe" {
  hostname        = "app.terraform.io"
  ssl_skip_verify = false
}
