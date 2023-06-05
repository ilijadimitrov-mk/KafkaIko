terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }


}
#terraform {
#	backend "remote" {
#		hostname = "app.terraform.io"
#		organization = "allocatesoftware"
#		workspaces {
#			name = "rld-tf-time247-Kafka"
#		}
#	}
#}

provider "aws" {
  region = "us-east-2"
}
