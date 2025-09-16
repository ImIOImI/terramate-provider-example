globals {
  env = "stg"
}

globals this {
  env = global.env
  aws = global.envs[global.env]
}
