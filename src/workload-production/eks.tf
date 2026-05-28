module "eks" {
  source       = "../../modules/eks"
  cluster_name = "eks-cluster-new"

  subnet_ids     = module.vpc.private_subnet_ids
  instance_types = ["t3.micro"]
  desired_size   = 2
  min_size       = 1
  max_size       = 3

  tags = {
    Name = "eks-cluster"
  }
}
