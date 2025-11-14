module "vpc" {
  source = "./Modules/VPC"
}

module "loadbalancer" {
  source           = "./Modules/lb"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "autoscaling" {
  source = "./Modules/autoscaling"
}