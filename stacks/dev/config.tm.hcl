globals {
  env = "dev"
}

globals this {
  env = global.env
  aws = global.envs[global.env]
}
