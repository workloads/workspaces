# see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_run_task
resource "tfe_organization_run_task" "snyk" {
  organization = tfe_organization.main.name
  url          = var.snyk_runtask_url
  name         = "snyk-${var.snyk_runtask_org}"
  enabled      = true
  description  = "Snyk Integration (Org: `${var.snyk_runtask_org}`)."
  hmac_key     = var.snyk_runtask_hmac_key
}
