provider "aws" {
  region  = var.aws_region
  profile = "prod"

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = "Bootstrap"
      ManagedBy   = "Terraform"
      Owner       = var.owner
    }
  }
}

