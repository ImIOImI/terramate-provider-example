# This creates a file that handles only the github provider setup
generate_hcl "_tmgen-provider-github.tf" {
  inherit = true

  condition = tm_alltrue([
    !tm_contains(terramate.stack.tags, "nogen"),
    tm_contains(terramate.stack.tags, "provider-github"),
    # define a dependency to doppler below by looking for its providers tags
    tm_contains(terramate.stack.tags, "provider-doppler"),
  ])

  content {
    data "doppler_secrets" "gh_pem" {
      project = "<project>"
      config  = "<config>"
    }

    provider "github" {
      owner = "MyAwesomeOrg" # replace with your GitHub org or user name
      app_auth {
        id              = "<app id>"  #ID of GitHub App
        installation_id = "<installation id>" #Installation ID of GitHub App
        # This assumes a PEM file is stored in Doppler in the project:<project>, config:<config>
        # and the key is TOFU_ACCESS_TO_GITHUB_PEM
        pem_file        = data.doppler_secrets.gh_pem.map.TOFU_ACCESS_TO_GITHUB_PEM
      }
    }
  }
}

# this creates a globals file that merges the github provider into the terrmate providers namespace
generate_hcl "_tmgen-provider-github-globals.tm.hcl" {
  inherit = true

  condition = tm_alltrue([
    tm_contains(terramate.stack.tags, "provider-github"),
  ])

  content {
    globals "terraform" "providers" "github" {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}
