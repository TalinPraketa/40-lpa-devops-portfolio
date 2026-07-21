terraform {
  required_version = "~> 1.0"

  backend "s3" {
    bucket         = "enterprise-event-streaming-platform-tfstate-760652872045"
    key            = "dev/network/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "enterprise-event-streaming-platform-tfstate-locks"
    encrypt        = true
    profile        = "prod"
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "prod"
}

module "vpc" {
  source = "../../modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "eks" {
  source = "../../modules/eks"

  project_name       = var.project_name
  environment        = var.environment
  cluster_version    = "1.36"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  instance_types = ["t3.medium"]

  desired_size = 3
  min_size     = 3
  max_size     = 6
}
