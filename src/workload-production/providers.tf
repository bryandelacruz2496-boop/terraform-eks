terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = ">= 2.12"
    # }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = ">= 2.24"
    # }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
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

# provider "helm" {
#   kubernetes = {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority)
#     exec = {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", "eks-cluster-new"]
#       command     = "aws"
#     }
#   }
# }

# Uncomment after EKS cluster is provisioned
# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", "eks-cluster-new"]
#     command     = "aws"
#   }
# }
