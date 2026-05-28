# Read VPC state to get subnet IDs
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "terraform-cicd-bucket-git"
    key    = "workload-production/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

module "eks" {
  source       = "../../../modules/eks"
  cluster_name = "eks-cluster"

  subnet_ids     = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  instance_types = ["t3.micro"]
  desired_size   = 2
  min_size       = 1
  max_size       = 3

  tags = {
    Name = "eks-cluster"
  }
}
