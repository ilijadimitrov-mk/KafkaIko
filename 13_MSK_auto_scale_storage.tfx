resource "aws_appautoscaling_target" "kafka_storage" {
  max_capacity       = 20
  min_capacity       = 1
  resource_id        = aws_msk_cluster.Time247MSK.arn
  scalable_dimension = "kafka:broker-storage:VolumeSize"
  service_namespace  = "kafka"
}

resource "aws_appautoscaling_policy" "kafka_broker_scaling_policy" {
  name               = "Time247MSK-broker-scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_msk_cluster.Time247MSK.arn
  scalable_dimension = aws_appautoscaling_target.kafka_storage.scalable_dimension
  service_namespace  = aws_appautoscaling_target.kafka_storage.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "KafkaBrokerStorageUtilization"
    }

    #    target_value = var.scaling_target_value
    target_value = 70
  }
}
