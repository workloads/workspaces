# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_run_task
resource "tfe_organization_run_task" "snyk" {
  description  = "Snyk Integration (Org: `${var.snyk_runtask_org}`)."
  enabled      = true
  hmac_key     = var.snyk_runtask_hmac_key
  name         = "snyk-${var.snyk_runtask_org}"
  organization = tfe_organization.main.name
  url          = var.snyk_runtask_url
}
