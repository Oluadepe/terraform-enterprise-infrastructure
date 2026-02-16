variable "region" { type = string default = "us-east-1" }
variable "project" { type = string default = "tf-enterprise" }
variable "environment" { type = string default = "dev" }

# Networking
variable "vpc_cidr" { type = string default = "10.10.0.0/16" }
variable "public_subnets" { type = list(string) default = ["10.10.0.0/20","10.10.16.0/20","10.10.32.0/20"] }
variable "private_subnets" { type = list(string) default = ["10.10.64.0/20","10.10.80.0/20","10.10.96.0/20"] }

# Optional modules
variable "enable_eks" { type = bool default = false }
variable "enable_rds" { type = bool default = false }
variable "db_username" { type = string default = "admin" }
variable "db_password" { type = string default = "" sensitive = true }
