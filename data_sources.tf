# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/oauth_client
data "tfe_oauth_client" "client" {
  oauth_client_id = var.tfe_oauth_client_id
}
