resource "aws_msk_cluster" "Time247MSK" {
  cluster_name           = "Time247MSK"
  kafka_version          = "2.8.1"
  number_of_broker_nodes = 3
  broker_node_group_info {
    instance_type = "kafka.t3.small" ##kafka.m5.4xlarge
    #    instance_type = "kafka.m5.xlarge" ##kafka.m5.4xlarge
    client_subnets = [
      var.subnet1_id,
      var.subnet2_id,
      var.subnet3_id,
    ]
    storage_info {
      ebs_storage_info {
        provisioned_throughput {
          enabled = false #true # sto znaci ova
          #          volume_throughput = "250"
        }
        volume_size = 10
      }
    }

    security_groups = [aws_security_group.kafka.id]
  }

  client_authentication {
    unauthenticated = false
    sasl {
      iam   = true
      scram = false
    }
    tls {
      certificate_authority_arns = null
    }
  }

  configuration_info {
    arn      = aws_msk_configuration.MSKConfig.arn
    revision = "1"
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.MSKLogs.name
      }
    }
  }

  open_monitoring {
    prometheus {
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  # encryption_info {
  #   encryption_at_rest_kms_key_arn = data.aws_kms_key.kafka.arn
  #    encryption_at_rest_kms_key_arn = aws_kms_key.key.arn
  # }
  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kafka.arn

    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  tags = {
    Environment = var.Environment
    Product     = var.Product
  }

  lifecycle {
    ignore_changes = [
      client_authentication,
    ]
  }
}



