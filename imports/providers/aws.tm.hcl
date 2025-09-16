generate_hcl "_tmgen-provider-aws.tf" {
  inherit = true

  condition = tm_alltrue([
    !tm_contains(terramate.stack.tags, "nogen"),
    tm_contains(terramate.stack.tags, "provider-aws"),
  ])

  content {
    provider "aws" {
      alias  = "infra"
      region = "us-east-1"
      assume_role {
        role_arn = global.envs["infra"].role_arn
      }
      default_tags {
        tags = globals.tags
      }
    }

    provider "aws" {
      region = "us-east-1"
      assume_role {
        role_arn = global.this.aws.role_arn
      }
      default_tags {
        tags = globals.tags
      }
    }
  }
}

generate_hcl "_tmgen-provider-aws-globals.tm.hcl" {
  inherit = true

  condition = tm_alltrue([
    !tm_contains(terramate.stack.tags, "nogen"),
    tm_contains(terramate.stack.tags, "provider-aws"),
  ])

  content {
    globals "terraform" "providers" "aws" {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}
