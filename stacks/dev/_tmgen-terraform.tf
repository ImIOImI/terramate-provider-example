// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  required_version = "1.10.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.13.0"
    }
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.20.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
  backend "s3" {
    assume_role = {
      role_arn = "arn:aws:iam::111111111111:role/TerraformAdmin"
    }
    bucket         = "my-awesome-state-dev"
    dynamodb_table = "my-awesome-state-dynamo"
    encrypt        = true
    key            = "stacks/by-id/b5353669-68ac-44a9-a0c2-dbd388a52ccc/terraform.tfstate"
    region         = "us-east-1"
  }
}
