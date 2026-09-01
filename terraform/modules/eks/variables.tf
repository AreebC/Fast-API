variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
}

variable "tags" {
    description = "A map of tags to assign to resources"
    type        = map(string)
    default     = {}
}

variable "eks_cluster_role_arn" {
    description = "The ARN of the EKS cluster IAM role"
    type        = string
}

variable "eks_nodegroup_role_arn" {
    description = "The ARN of the EKS nodegroup IAM role"
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC where the EKS cluster will be deployed"
    type        = string
}

variable "subnet_ids" {
    description = "A list of subnet IDs for the EKS cluster"
    type        = list(string)
}

variable "node_group_desired_size" {
    description = "The desired number of nodes in the EKS node group"
    type        = number
    default     = 2
}

variable "node_group_max_size" {
    description = "The maximum number of nodes in the EKS node group"
    type        = number
    default     = 3
}

variable "node_group_min_size" {
    description = "The minimum number of nodes in the EKS node group"
    type        = number
    default     = 1
}

variable "node_group_instance_types" {
    description = "The instance types for the EKS node group"
    type        = list(string)
    default     = ["m5.large"]
}

variable "private_subnet_cidrs" {
    description = "A list of CIDR blocks for the private subnets"
    type        = list(string)
    default     = []
}