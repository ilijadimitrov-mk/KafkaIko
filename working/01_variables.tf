variable "subnet1" {
  description = "A list of private subnets inside the VPC"
  type        = string
}


variable "subnet2" {
  description = "A list of private subnets inside the VPC"
  type        = string
}


variable "subnet3" {
  description = "A list of private subnets inside the VPC"
  type        = string
}

variable "subnet1_id" {
  description = "A list of private subnets inside the VPC"
  type        = string
}


variable "subnet2_id" {
  description = "A list of private subnets inside the VPC"
  type        = string
}


variable "subnet3_id" {
  description = "A list of private subnets inside the VPC"
  type        = string
}


variable "vpc_id" {
  type = string
}


variable "vpc_cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "Environment" {
  type    = string
  default = "Lab"
}

variable "Product" {
  type    = string
  default = "Time247"
}

