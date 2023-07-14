resource "aws_kms_key" "kafka" {
  enable_key_rotation = true
  description         = "KMS key kafka"
}

resource "aws_kms_key" "cloudwatch" {
  enable_key_rotation = true
  description         = "KMS key cloudwatch"
}


resource "aws_kms_key_policy" "cloudwatch" {
  key_id = aws_kms_key.cloudwatch.id
  policy = jsonencode({
    Id = "Cloudwatch"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}
