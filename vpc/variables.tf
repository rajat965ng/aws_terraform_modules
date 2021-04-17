variable "cidr" {
  description = "CIDR block"
}

variable "private_subnet_cidr" {
  description = "CIDR block of Subnet"
}

variable "public_subnet_cidr" {
  description = "CIDR block of Subnet"
}

variable "name" {
  description = "Name of VPC"
}

variable "env" {
  description = "Environment Name"
}

variable "region" {
  description = "Region"
}