variable "region" {
  description = "The AWS region"
}

variable "project_name" {
  description = "The name of the project"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "public_subnet_1_cidr" {
  description = "The CIDR block for public subnet 1"
}

variable "public_subnet_2_cidr" {
  description = "The CIDR block for public subnet 2"
}

variable "private_subnet_1_cidr" {
  description = "The CIDR block for private subnet 1"
}

variable "private_subnet_2_cidr" {
  description = "The CIDR block for private subnet 2"
}