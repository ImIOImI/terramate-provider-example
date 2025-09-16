# this creates a file named _tmgen-terraform.tf with the required_providers block and other terraform setup
generate_hcl "_tmgen-terraform.tf" {
  condition = tm_alltrue([
    !tm_contains(terramate.stack.tags, "nogen"),
  ])

  lets {
    required_providers = {
      for k, v in tm_try(global.terraform.providers, {}) :
      k => {
        source  = v.source
        version = v.version
      }
    }
  }

  content {
    terraform {
      required_version = global.tofu_version

      tm_dynamic "required_providers" {
        attributes = let.required_providers
      }

      backend "s3" {
        region = tm_try(global.terraform.backend.region, "us-east-1")
        bucket = tm_try(global.terraform.backend.bucket, "my-awesome-state")
        key     = "stacks/by-id/${terramate.stack.id}/terraform.tfstate"
        encrypt = true
        dynamodb_table = tm_try(global.terraform.backend.dynamo_table, "my-awesome-state-dynamo")

        assume_role = {
          role_arn = global.this.aws.role_arn
        }
      }
    }
  }
}

# this generates an opentofu version file so tenv works automagically
generate_file ".opentofu-version" {
  content = <<EOT
    ${global.tofu_version}

  EOT
}
