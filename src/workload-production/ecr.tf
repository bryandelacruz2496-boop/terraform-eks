module "demo_api_ecr" {
  source               = "../../modules/ecr"
  name                 = "demo-api"
  image_tag_mutability = "MUTABLE"
}
