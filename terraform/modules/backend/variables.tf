variable "bucket_name" {
  description = "Name of the S3 bucket"
  default     = "terraform-state-backend-1"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  default     = "akash-db-terraform-state-lock"
}