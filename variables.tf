variable "name" {
}

variable "region" {
}

variable "aws_vpc_id" {
}

variable "aws_subnet_a" {
}

variable "aws_subnet_b" {
}

variable "aws_subnet_с" {
}

data "aws_vpc" "lab-vpc" {
  id = var.aws_vpc_id
}

data "aws_subnet" "lab-a" {
  id = var.aws_subnet_a
}

data "aws_subnet" "lab-b" {
  id = var.aws_subnet_b
}

data "aws_subnet" "lab-с" {
  id = var.aws_subnet_с
}

data "aws_msk_cluster" "main" {
  cluster_name = aws_msk_cluster.main.cluster_name
}
