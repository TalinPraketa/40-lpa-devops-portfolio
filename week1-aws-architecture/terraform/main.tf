module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
  alb_sg_id         = module.sg.alb_sg_id
}

module "asg" {
  source              = "./modules/asg"
  private_subnets     = module.vpc.private_subnets
  app_sg_id           = module.sg.app_sg_id
  target_group_arn    = module.alb.target_group_arn
}

module "bastion" {
  source          = "./modules/bastion"
  public_subnet   = module.vpc.public_subnets[0]
  bastion_sg_id   = module.sg.bastion_sg_id
}

module "rds" {
  source          = "./modules/rds"
  private_subnets = module.vpc.private_subnets
  app_sg_id       = module.sg.app_sg_id

  db_username = "admin"
  db_password = "password123"   # ⚠️ temp only
}
