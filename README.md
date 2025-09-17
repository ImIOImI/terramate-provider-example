# Dynamic Provider Example with Terramate

The purpose of this repo is to demonstrate how to have create several dynamically generated 
providers that require more than just a simple provider block.

## Features

Please note that everything with a `_tmgen` prefix is dynamically generated tofu code. Each stack is a code artifact.

### Dynamically generated provider with data sources it depends one

When a stack has the tags `provider-doppler` and `provider-aws` we can automagically generate
a doppler provider that uses a token stored in AWS Secrets Manager.

```hcl 
  # imports/providers/doppler.tm.hcl
  condition = tm_alltrue([
    !tm_contains(terramate.stack.tags, "nogen"),
    tm_contains(terramate.stack.tags, "provider-doppler"),
    # listing provider-aws here to codify doppler's dependency on aws secrets manager for Doppler's token
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
```

### Backend State Storage In Each AWS Account

Generate an S3 backend in each AWS account to segregate state file access

```hcl
# imports/global/terraform.tm.hcl
terraform {
  ...

  backend "s3" {
    region = tm_try(global.terraform.backend.region, "us-east-1")
    bucket = tm_try(global.terraform.backend.bucket, "my-awesome-state-${global.this.env}")
    key     = "stacks/by-id/${terramate.stack.id}/terraform.tfstate"
    encrypt = true
    dynamodb_table = tm_try(global.terraform.backend.dynamo_table, "my-awesome-state-dynamo")

    assume_role = {
      role_arn = global.this.aws.role_arn
    }
  }
}
```

### Allow for dynamically generating default AWS Providers and aliased providers

With the following configuration I can generate a default AWS provider for whatever account I'm in, and an aliased 
provider for an "infra" account for where shared resources are stored (like the Doppler token).

```hcl
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
```