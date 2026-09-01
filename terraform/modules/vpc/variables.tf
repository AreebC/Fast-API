variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "vpc_name" {
    description = "The name of the VPC"
    type        = string
}

variable "env" {
    description = "The environment for the VPC"
    type        = string
}

variable "subnet_cidr_block" {
    description = "The CIDR block for the public subnet"
    type        = string
}

variable "subnet_cidr_block2" {
    description = "The CIDR block for the second public subnet"
    type        = string
}

variable "private_subnet_cidr_block" {
    description = "The CIDR block for the private subnet"
    type        = string
}

variable "private_subnet_cidr_block2" {
    description = "The CIDR block for the second private subnet"
    type        = string
}

variable "availability_zone" {
    description = "The availability zone for the public subnet"
    type        = string
}

variable "availability_zone2" {
    description = "The availability zone for the second public subnet"
    type        = string
}

variable "tags" {
    description = "Additional tags to apply to resources"
    type        = map(string)
    default     = {}
}