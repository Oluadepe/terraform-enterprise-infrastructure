data "aws_caller_identity" "current" {}

resource "aws_kms_key" "main" {
  description             = "KMS key for ${var.name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags                    = merge(var.tags, { Name = "${var.name}-kms" })
}

resource "aws_iam_role" "baseline" {
  name = "${var.name}-baseline-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
  tags = merge(var.tags, { Name = "${var.name}-baseline-role" })
}

resource "aws_iam_role_policy" "baseline" {
  name = "${var.name}-baseline-policy"
  role = aws_iam_role.baseline.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["kms:Encrypt","kms:Decrypt","kms:GenerateDataKey","kms:DescribeKey"],
        Resource = aws_kms_key.main.arn
      }
    ]
  })
}
