terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
    kafka = {
      source = "Mongey/kafka"
      version = "0.8.3"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "kafka" {
  bootstrap_servers = data.aws_msk_cluster.main.bootstrap_brokers_tls
  skip_tls_verify   = true
  tls_enabled       = true
}
