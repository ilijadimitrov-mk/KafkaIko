resource "aws_cloudwatch_log_group" "MSKLogs" {
  name = "MSKLogs"
  retention_in_days = 14
  tags = {
    Environment = var.Environment
    Product = var.Product
  }
}
