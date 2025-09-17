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
      role_arn = "arn:aws:iam::222222222222:role/TerraformAdmin"
    }
    bucket         = "my-awesome-state-stg"
    dynamodb_table = "my-awesome-state-dynamo"
    encrypt        = true
    key            = "stacks/by-id/ff3c0192-84ac-4553-8d8c-9be25dae1590/terraform.tfstate"
    region         = "us-east-1"
  }
}
