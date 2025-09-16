globals {
  env = "infra"
}

globals this {
  env = global.env
  aws = global.envs[global.env]
}
