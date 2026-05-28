provider "aws" {
  region = var.aws_region
}

module "terraform_state" {
  source = "./modules/s3-state"

  bucket_name         = var.state_bucket_name
  dynamodb_table_name = var.lock_table_name

  tags = {
    Project   = "terraform-eks"
    ManagedBy = "terraform"
  }
}
