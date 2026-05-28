# S3 Terraform State Module

Creates an S3 bucket for storing Terraform state files with best-practice security configurations, plus an optional DynamoDB table for state locking.

## Features

- S3 bucket with versioning enabled
- Server-side encryption (AWS KMS)
- Public access fully blocked
- Lifecycle rule to expire old noncurrent versions
- Optional DynamoDB table for state locking

## Usage

```hcl
module "terraform_state" {
  source = "./modules/s3-state"

  bucket_name         = "my-project-terraform-state"
  dynamodb_table_name = "my-project-terraform-lock"

  tags = {
    Environment = "shared"
    ManagedBy   = "terraform"
  }
}
```

Then configure your backend:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-project-terraform-state"
    key            = "eks/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "my-project-terraform-lock"
    encrypt        = true
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| bucket_name | Name of the S3 bucket | string | - | yes |
| enable_dynamodb_lock | Create DynamoDB lock table | bool | true | no |
| dynamodb_table_name | Name of the DynamoDB table | string | "terraform-state-lock" | no |
| noncurrent_version_expiration_days | Days to keep old versions | number | 90 | no |
| tags | Tags for all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The S3 bucket name |
| bucket_arn | The S3 bucket ARN |
| bucket_region | The S3 bucket region |
| dynamodb_table_name | The DynamoDB table name |
| dynamodb_table_arn | The DynamoDB table ARN |
