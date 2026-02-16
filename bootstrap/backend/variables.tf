variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "tf-enterprise"
}

variable "state_bucket_name" {
  type        = string
  description = "Unique S3 bucket name for Terraform state"
  default     = ""
}

variable "lock_table_name" {
  type        = string
  description = "DynamoDB table name for Terraform state locking"
  default     = "tf-enterprise-locks"
}
