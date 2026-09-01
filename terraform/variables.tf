variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "eks_cluster_role_name" {
  description = "The name of the IAM role for the EKS cluster"
  type        = string
}

variable "eks_nodegroup_role_name" {
  description = "The name of the IAM role for the EKS node group"
  type        = string
}

variable "eks_nodegroup_instance_profile_name" {
  description = "The name of the IAM instance profile for the EKS node group"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace for the service accounts"
  type        = string
}

variable "ecr_pull_service_account_name" {
  description = "The name of the Kubernetes service account for ECR pull access"
  type        = string
}

variable "loki_service_account_name" {
  description = "The name of the Kubernetes service account for Loki"
  type        = string
}

variable "bucket_name1" {
  description = "The name of the first S3 bucket"
  type        = string
}

variable "bucket_name2" {
  description = "The name of the second S3 bucket"
  type        = string
}

variable "bucket_name3" {
  description = "The name of the third S3 bucket"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "env" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the first public subnet"
  type        = string
}

variable "subnet_cidr_block2" {
  description = "The CIDR block for the second public subnet"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_cidr_block2" {
  description = "The CIDR block for the second private subnet"
  type        = string
}

variable "availability_zone" {
  description = "The first availability zone for the subnets"
  type        = string
}

variable "availability_zone2" {
  description = "The second availability zone for the subnets"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "node_group_desired_size" {
  description = "The desired number of nodes in the EKS node group"
  type        = number
}

variable "node_group_max_size" {
  description = "The maximum number of nodes in the EKS node group"
  type        = number
}

variable "node_group_min_size" {
  description = "The minimum number of nodes in the EKS node group"
  type        = number
}

variable "node_group_instance_types" {
  description = "The instance types for the EKS node group"
  type        = list(string)
}

variable "alb_namespace" {
  description = "The Kubernetes namespace for the AWS Load Balancer Controller"
  type        = string
}

variable "alb_service_account_name" {
  description = "The name of the Kubernetes service account for the AWS Load Balancer Controller"
  type        = string
}



