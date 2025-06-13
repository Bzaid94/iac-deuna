module "kms" {
  source      = "./kms"
  environment = var.environment
}

module "s3" {
  source      = "./s3"
  environment = var.environment
  kms_key_arn = module.kms.key_arn
}

module "rds" {
  source           = "./rds"
  environment      = var.environment
  kms_key_arn      = module.kms.key_arn
  pgadmin_username = var.pgadmin_username
  pgadmin_password = var.pgadmin_password
}

module "secrets" {
  source           = "./secrets"
  environment      = var.environment
  pgadmin_username = var.pgadmin_username
  pgadmin_password = var.pgadmin_password
}