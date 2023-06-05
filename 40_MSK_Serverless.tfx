resource "aws_msk_serverless_cluster" "demo-cluster-1" {
  cluster_name = "demo-cluster-1"

 vpc_config {
   subnet_ids         = [var.subnet1_id, var.subnet2_id, var.subnet3_id]
#  subnet_ids         = aws_subnet.example[*].id
   security_group_ids = [aws_security_group.kafka.id]
#   security_group_ids = [aws_security_group.example.id]
 }

  client_authentication {
    sasl {
      iam {
        enabled = true
      }
    }
  }
}
