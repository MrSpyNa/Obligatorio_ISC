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
  public_subnet_ids = module.vpc.private_subnet_ids

}
