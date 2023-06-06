resource "aws_security_group" "kafka" {
  name        = "sg_msk_kafka"
  description = "Access to managed Kafka"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Access From itself"
    self        = true
  }
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["sg-781e0a18"]
    description     = "Allow from serevr1"
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["sg-09c502c316dd47be8"]
    description     = "Allow from serevr2"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #  ipv6_cidr_blocks = ["::/0"]
    description = "Allow outbound"
  }

  tags = {
    Name        = "sg_msk_kafka"
    Environment = var.Environment
  }

}
