// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "doppler_secrets" "gh_pem" {
  config  = "<config>"
  project = "<project>"
}
provider "github" {
  owner = "MyAwesomeOrg"
  app_auth {
    id              = "<app id>"
    installation_id = "<installation id>"
    pem_file        = data.doppler_secrets.gh_pem.map.TOFU_ACCESS_TO_GITHUB_PEM
  }
}
