variable "region" { type = string default = "us-east-1" }
variable "project" { type = string default = "tf-enterprise" }
variable "environment" { type = string default = "staging" }

# Networking
variable "vpc_cidr" { type = string default = "10.20.0.0/16" }
variable "public_subnets" { type = list(string) default = ["10.20.0.0/20","10.20.16.0/20","10.20.32.0/20"] }
variable "private_subnets" { type = list(string) default = ["10.20.64.0/20","10.20.80.0/20","10.20.96.0/20"] }

# Optional modules
variable "enable_eks" { type = bool default = false }
variable "enable_rds" { type = bool default = false }
variable "db_username" { type = string default = "admin" }
variable "db_password" { type = string default = "" sensitive = true }
