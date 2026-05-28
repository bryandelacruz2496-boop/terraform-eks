output "bucket_id" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.arn
}

output "bucket_region" {
  description = "The AWS region of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.region
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB lock table"
  value       = var.enable_dynamodb_lock ? aws_dynamodb_table.terraform_lock[0].name : null
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB lock table"
  value       = var.enable_dynamodb_lock ? aws_dynamodb_table.terraform_lock[0].arn : null
}
