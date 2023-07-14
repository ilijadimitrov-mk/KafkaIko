resource "aws_cloudwatch_log_group" "MSKLogs" {
  name              = "MSKLogs"
  retention_in_days = 400
#  kms_key_id        = "arn:aws:kms:us-east-2:386743670652:key/a639bf65-e74e-4bb6-817a-8cedb1275208"
  kms_key_id        = aws_kms_key.cloudwatch.arn
  tags = {
    Environment = var.Environment
    Product     = var.Product
  }
}
