module "demo_api_ecr" {
  source               = "../../modules/ecr"
  name                 = "demo-api-eks"
  image_tag_mutability = "MUTABLE"
}
