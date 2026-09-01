output "vpc_id" {
    description = "The ID of the VPC"
    value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
    description = "The IDs of the public subnets"
    value       = [aws_subnet.subnet.id, aws_subnet.subnet2.id]
}

output "private_subnet_ids" {
    description = "The IDs of the private subnets"
    value       = [aws_subnet.private_subnet.id, aws_subnet.private_subnet2.id]
}

output "private_subnet_cidrs" {
    description = "The CIDR blocks of the private subnets"
    value       = [aws_subnet.private_subnet.cidr_block, aws_subnet.private_subnet2.cidr_block]
}

output "availability_zones" {
    description = "The availability zones used in the VPC"
    value       = [var.availability_zone, var.availability_zone2]
}
