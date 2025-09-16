// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "doppler_secrets" "gh_pem" {
  config  = "<config>"
  project = "<project>"
}
provider "github" {
  owner = "MyAwesomeOrg"
  app_auth {
    id              = "<ap id>"
    installation_id = "<installation id>"
    pem_file        = data.doppler_secrets.gh_pem.map.TOFU_ACCESS_TO_SUMER_GITHUB_PEM
  }
}
