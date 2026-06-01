module "eks" {
  source          = "../../modules/eks"
  cluster_name    = "eks-cluster-new-demo"
  cluster_version = "1.30"
  region          = "ap-southeast-1"

  subnet_ids     = module.vpc.public_subnet_ids
  instance_types = ["t3.micro"]
  desired_size   = 2
  min_size       = 1
  max_size       = 3

  tags = {
    Name = "eks-cluster-test"
  }
}

# Access entry for eks-test user (kubectl/developer access)
resource "aws_eks_access_entry" "eks_test_user" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::767397778742:user/eks-test"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "eks_test_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::767397778742:user/eks-test"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
