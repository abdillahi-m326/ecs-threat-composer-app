module "vpc" {
  source = "./modules/vpc"

  name_prefix          = var.name_prefix
  vpc_cidr             = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = var.tags
}
module "alb" {
  source             = "./modules/alb"
  name_prefix        = var.name_prefix
  security_group_ids = [module.securitygroup.security_group_id]
  subnet_ids         = module.vpc.public_subnet_ids
  tags               = var.tags

  certificate_arn                = module.acm.certificate_arn
  https_forward_target_group_arn = module.targetgroup.target_group_arn

  http_enabled           = true
  redirect_http_to_https = true
}

module "acm" {
  source                    = "./modules/acm"
  domain_name               = "abdillahi-ecs-app.click"
  subject_alternative_names = ["www.abdillahi-ecs-app.click"]

  zone_name = "abdillahi-ecs-app.click"

  tags = {
    Environment = "production"
    Owner       = "platform-team"
  }
}

module "iam" {
  source      = "./modules/iam"
  name_prefix = var.name_prefix
  tags        = var.tags

  task_managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]
}

module "route53" {
  source = "./modules/route53"

  zone_name     = "abdillahi-ecs-app.click"
  alias_name    = module.alb.alb_dns_name
  alias_zone_id = module.alb.alb_zone_id

  enable_root_record = true
  enable_www_record  = true
}

module "securitygroup" {
  source      = "./modules/securitygroup"
  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id
  tags        = var.tags
}

module "targetgroup" {
  source      = "./modules/targetgroup"
  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  tags        = var.tags
}
