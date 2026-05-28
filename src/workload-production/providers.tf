terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-cicd-bucket-git"
    key            = "workload-production/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-eks-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-southeast-1"

  default_tags {
    tags = {
      Environment = "production"
      Project     = "terraform-eks"
      ManagedBy   = "Terraform"
    }
  }
}
