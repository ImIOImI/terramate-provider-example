globals {
  tofu_version = "1.10.5"

  envs = {
    dev = {
      account_id = "111111111111"
      role_arn   = "arn:aws:iam::111111111111:role/TerraformAdmin"
    }
    stg = {
      account_id = "222222222222"
      role_arn   = "arn:aws:iam::222222222222:role/TerraformAdmin"
    }
    prd = {
      account_id = "333333333333"
      role_arn   = "arn:aws:iam::333333333333:role/TerraformAdmin"
    }
    infra = {
      account_id = "444444444444"
      role_arn   = "arn:aws:iam::444444444444:role/TerraformAdmin"
    }
  }

  tags = {
    Env        = global.this.env
    CostCenter = "please-categorize-me"
    StackId    = terramate.stack.id
    StackName  = terramate.stack.name
    Tofu       = "Managed by Terraform"
  }
}