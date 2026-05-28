output "state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  value       = module.terraform_state.bucket_id
}

output "state_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.terraform_state.bucket_arn
}

output "lock_table_name" {
  description = "DynamoDB lock table name"
  value       = module.terraform_state.dynamodb_table_name
}
