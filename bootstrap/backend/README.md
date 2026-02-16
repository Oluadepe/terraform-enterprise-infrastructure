# Remote State Backend Bootstrap (S3 + DynamoDB)

This bootstrap creates:
- S3 bucket for Terraform remote state
- DynamoDB table for state locking
- Recommended encryption + versioning

## Apply
```bash
terraform init
terraform apply -auto-approve
```

## Outputs
- state_bucket_name
- lock_table_name
