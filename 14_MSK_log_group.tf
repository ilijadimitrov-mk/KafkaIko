resource "aws_cloudwatch_log_group" "MSKLogs" {
  name              = "MSKLogs"
  retention_in_days = 400
  kms_key_id        = aws_kms_key.cloudwatch.arn
  tags = {
    Environment = var.Environment
    Product     = var.Product
  }
}
