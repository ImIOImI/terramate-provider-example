// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "aws_secretsmanager_secret" "doppler" {
  name     = "doppler-admin"
  provider = aws
}
data "aws_secretsmanager_secret_version" "doppler" {
  provider  = aws
  secret_id = data.aws_secretsmanager_secret.doppler.id
}
data "doppler_secrets" "this" {
  config  = "infra"
  project = "doppler"
}
provider "doppler" {
  doppler_token = data.aws_secretsmanager_secret_version.doppler.secret_string
}
