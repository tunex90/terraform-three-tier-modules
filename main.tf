module "networking" {
  source = "./modules/networking"

  vpc_cidr           = var.vpc_cidr
  web_public_a_cidr  = var.web_public_a_cidr
  web_public_b_cidr  = var.web_public_b_cidr
  app_private_a_cidr = var.app_private_a_cidr
  app_private_b_cidr = var.app_private_b_cidr
  db_private_a_cidr  = var.db_private_a_cidr
  db_private_b_cidr  = var.db_private_b_cidr
  az_a               = var.az_a
  az_b               = var.az_b
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.networking.vpc_id
}

module "compute" {
  source = "./modules/compute"

  ami_owner        = var.ami_owner
  instance_type    = var.instance_type
  key_name         = var.key_name
  web_public_a_id  = module.networking.web_public_a_id
  web_public_b_id  = module.networking.web_public_b_id
  app_private_a_id = module.networking.app_private_a_id
  db_private_a_id  = module.networking.db_private_a_id
  web_sg_id        = module.security_groups.web_sg_id
  app_sg_id        = module.security_groups.app_sg_id
  db_sg_id         = module.security_groups.db_sg_id
}
