variable "name" { type = string }
variable "subnet_ids" { type = list(string) }
variable "vpc_id" { type = string }
variable "cluster_version" { type = string default = "1.29" }
variable "tags" { type = map(string) default = {} }
