locals {
  name_prefix = "${var.project}-${var.environment}"
  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "vpc" {
  source          = "../../modules/vpc"
  name            = "${local.name_prefix}-vpc"
  cidr            = var.vpc_cidr
  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags            = local.tags
}

module "iam" {
  source = "../../modules/iam"
  name   = local.name_prefix
  tags   = local.tags
}

module "eks" {
  count          = var.enable_eks ? 1 : 0
  source         = "../../modules/eks"
  name           = local.name_prefix
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
  cluster_version = "1.29"
  tags           = local.tags
}

module "rds" {
  count       = var.enable_rds ? 1 : 0
  source      = "../../modules/rds"
  name        = local.name_prefix
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
  db_username = var.db_username
  db_password = var.db_password
  tags        = local.tags
}
