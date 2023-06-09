
resource "aws_msk_configuration" "MSKConfig" {
  kafka_versions = ["2.8.1"]
  name           = "MSKConfig"

  server_properties = <<PROPERTIES
auto.create.topics.enable = true
delete.topic.enable = true
default.replication.factor=3
min.insync.replicas=2
num.io.threads=8
num.network.threads=5
num.partitions=1
num.replica.fetchers=2
replica.lag.time.max.ms=30000
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
socket.send.buffer.bytes=102400
unclean.leader.election.enable=true
zookeeper.session.timeout.ms=18000
PROPERTIES
}

output "latest_revision" {
  value       = one(aws_msk_configuration.MSKConfig[*].latest_revision)
  description = "Latest revision of the MSK configuration"
}
