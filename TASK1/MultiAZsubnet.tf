locals {
  public_cidr_block  = cidrsubnet(var.vpc_cidr, 1, 0)
  private_cidr_block = cidrsubnet(var.vpc_cidr, 1, 1)
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "0.21.1"

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  cidr_block = var.vpc_cidr
}

module "public_subnets" {
  source  = "cloudposse/multi-az-subnets/aws"
  version = "0.12.0"

  namespace           = var.namespace
  stage               = var.stage
  name                = var.name
  availability_zones  = var.availability_zones
  vpc_id              = module.vpc.vpc_id
  cidr_block          = local.public_cidr_block
  type                = "public"
  igw_id              = module.vpc.igw_id
  nat_gateway_enabled = "true"
}



module "private_subnets" {
  source = "cloudposse/multi-az-subnets/aws"
  version = "0.12.0"

  namespace          = var.namespace
  stage              = var.stage
  name               = var.name
  availability_zones = var.availability_zones
  vpc_id             = module.vpc.vpc_id
  cidr_block         = local.private_cidr_block
  type               = "private"

  az_ngw_ids = module.public_subnets.az_ngw_ids
}

