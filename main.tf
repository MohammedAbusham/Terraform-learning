terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  name                 = var.name
  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

module "alb" {
  source = "./modules/alb"

  name                 = var.name
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  allowed_ingress_cidr = var.allowed_ingress_cidr
  container_port       = var.container_port
  health_check_path    = var.health_check_path
  tags                 = var.tags
}

module "ecs" {
  source = "./modules/ecs"

  name                   = var.name
  aws_region             = var.aws_region
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  ecs_service_sg_id      = module.vpc.ecs_service_sg_id
  private_route_table_id = module.vpc.private_route_table_id
  target_group_arn       = module.alb.target_group_arn
  alb_security_group_id  = module.alb.alb_security_group_id

  container_image = var.container_image
  container_port  = var.container_port
  desired_count   = var.desired_count
  cpu             = var.cpu
  memory          = var.memory

  tags = var.tags
}

module "dns" {
  source = "./modules/dns"

  route53_zone_name = var.route53_zone_name
  dns_record_name   = var.dns_record_name
  alb_dns_name      = module.alb.alb_dns_name
  alb_zone_id       = module.alb.alb_zone_id
}