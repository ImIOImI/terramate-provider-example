globals {
  env = "prd"
}

globals this {
  env = global.env
  aws = global.envs[global.env]
}
