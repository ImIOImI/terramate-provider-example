generate_hcl "_tmgen-provider-doppler.tf" {
  inherit = true

  condition = tm_alltrue([
    !tm_contains(terramate.stack.tags, "nogen"),
    tm_contains(terramate.stack.tags, "provider-doppler"),
    tm_contains(terramate.stack.tags, "provider-aws"),
  ])

  content {
    # lets grab the doppler token from aws secrets manager
    data "aws_secretsmanager_secret" "doppler" {
      name     = "doppler-admin"
      provider = aws.infra
    }
    data "aws_secretsmanager_secret_version" "doppler" {
      secret_id = data.aws_secretsmanager_secret.doppler.id
      provider  = aws.infa
    }
    data "doppler_secrets" "this" {
      config  = "infra"
      project = "doppler"
    }
    provider "doppler" {
      doppler_token = data.aws_secretsmanager_secret_version.doppler.secret_string
    }
  }
}

# this creates a globals file that merges the doppler provider into the terrmate providers namespace
generate_hcl "_tmgen-provider-doppler-globals.tm.hcl" {
  inherit = true

  condition = tm_alltrue([
    !tm_contains(terramate.stack.tags, "nogen"),
    tm_contains(terramate.stack.tags, "provider-doppler"),
    tm_contains(terramate.stack.tags, "provider-aws"),
  ])

  content {
    globals "terraform" "providers" "doppler" {
      source  = "DopplerHQ/doppler"
      version = "1.20.0"
    }
  }
}
