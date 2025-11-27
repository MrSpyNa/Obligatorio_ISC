module "vpc" {
  source = "./Modules/VPC"
}

module "loadbalancer" {
  source            = "./Modules/lb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "autoscaling" {
  source                = "./Modules/autoscaling"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  target_group_arn      = module.loadbalancer.target_group_arn
  alb_security_group_id = module.loadbalancer.alb_security_group_id
  db_database           = module.database.db_name
  db_endpoint           = module.database.db_endpoint
  db_password           = module.database.db_password
  db_user               = module.database.db_user
  git_token             = var.git_token
  public_subnet_ids     = module.vpc.private_subnet_ids
}
module "database" {
  source             = "./Modules/database"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  asg_sg_id          = module.autoscaling.asg_sg_id
  db_password        = var.db_password
}