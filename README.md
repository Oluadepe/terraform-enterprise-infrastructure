# Terraform Enterprise Infrastructure (Modules + Environments: dev/staging/prod)

**Version:** v1.0.0 (Generated 2026-02-14)

A production-style Terraform repository that demonstrates how to build **reusable modules** and deploy them into **multiple environments** (dev, staging, prod) using consistent naming, tagging, and state isolation.

This repo provisions a realistic baseline platform on AWS:
- Networking (**VPC**, subnets, NAT)
- Compute layer (**EKS** optional module included)
- Data layer (**RDS** optional module included)
- Security/IAM baseline (**KMS**, IAM roles/policies, security groups)
- Environment separation (**dev / staging / prod**) with isolated state backends

---

## Architecture

![Architecture](docs/architecture.png)

### Key concepts
- **Modules** are reusable building blocks (`modules/vpc`, `modules/eks`, `modules/rds`, `modules/iam`).
- **Environments** use modules with different parameters (`environments/dev`, `environments/staging`, `environments/prod`).
- **Remote state** (S3 + DynamoDB) prevents conflicts and enables team workflows.
- **Consistent tags** and naming make cost allocation and governance easier.

---

## Repository Layout

```text
terraform-enterprise-infrastructure/
├── modules/
│   ├── vpc/
│   ├── eks/
│   ├── rds/
│   └── iam/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── prod/
├── bootstrap/
│   ├── backend/                    # creates S3 + DynamoDB for remote state
│   └── README.md
└── docs/
    └── architecture.png
```

---

## Prerequisites

- Terraform >= 1.6
- AWS CLI v2
- AWS account with permissions to create:
  - S3, DynamoDB, IAM, VPC, EKS (optional), RDS (optional)
- A workstation with access to your AWS credentials (SSO or IAM role)

Verify access:
```bash
aws sts get-caller-identity
```

---

## Step 0 — Bootstrap remote state (recommended)

Before running environments, create a remote state backend so each environment has isolated state.

### 0.1 Deploy backend (S3 + DynamoDB)
```bash
cd bootstrap/backend
terraform init
terraform apply -auto-approve
```

### 0.2 Use backend outputs
Terraform outputs:
- `state_bucket_name`
- `lock_table_name`

You will use these values in environment `backend.tf` files.

---

## Step 1 — Deploy DEV environment

### 1.1 Configure backend for DEV
Edit:
- `environments/dev/backend.tf`

Paste:
- `bucket = "<state_bucket_name>"`
- `dynamodb_table = "<lock_table_name>"`

### 1.2 Initialize and apply
```bash
cd environments/dev
terraform init
terraform apply -auto-approve
```

---

## Step 2 — Deploy STAGING and PROD

Repeat for each environment:

```bash
cd environments/staging
terraform init
terraform apply -auto-approve
```

```bash
cd environments/prod
terraform init
terraform apply -auto-approve
```

---

## What gets deployed by default?

By default, each environment deploys:
- VPC with public/private subnets + NAT
- KMS key
- IAM baseline role
- Security group baseline

Optional modules (toggle by variables):
- EKS cluster
- RDS database

---

## Enabling optional modules

### Enable EKS
In an environment `terraform.tfvars`:
```hcl
enable_eks = true
```

### Enable RDS
```hcl
enable_rds = true
db_username = "admin"
db_password = "replace-with-strong-password"
```

---

## Outputs you care about
- VPC ID, subnet IDs
- KMS key ARN
- EKS cluster name/endpoint (if enabled)
- RDS endpoint (if enabled)

---

## Cleanup
Destroy an environment:
```bash
cd environments/dev
terraform destroy -auto-approve
```

Destroy backend (only after all envs are destroyed):
```bash
cd bootstrap/backend
terraform destroy -auto-approve
```

---

## Next “FAANG-level” improvements
- Add Atlantis or Terraform Cloud workflows
- Add policy-as-code (OPA/Sentinel)
- Add unit tests (terraform validate + tflint + checkov)
- Add cost controls (Budgets, tags enforcement)
