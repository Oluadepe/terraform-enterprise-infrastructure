output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnets" { value = module.vpc.public_subnet_ids }
output "private_subnets" { value = module.vpc.private_subnet_ids }

output "kms_key_arn" { value = module.iam.kms_key_arn }
output "baseline_role_arn" { value = module.iam.baseline_role_arn }

output "eks_cluster_name" {
  value       = try(module.eks[0].cluster_name, null)
  description = "EKS cluster name (if enabled)"
}

output "rds_endpoint" {
  value       = try(module.rds[0].db_endpoint, null)
  description = "RDS endpoint (if enabled)"
}
