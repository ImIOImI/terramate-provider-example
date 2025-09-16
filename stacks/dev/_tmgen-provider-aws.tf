// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

provider "aws" {
  alias  = "infra"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::444444444444:role/TerraformAdmin"
  }
  default_tags {
    tags = globals.tags
  }
}
provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::111111111111:role/TerraformAdmin"
  }
  default_tags {
    tags = globals.tags
  }
}
