resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability
  force_delete         = true

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  tags = var.tags
}
