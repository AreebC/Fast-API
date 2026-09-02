variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
}

variable "eks_cluster_role_name" {
  description = "The name of the EKS cluster IAM role"
  type        = string
}

variable "eks_nodegroup_role_name" {
  description = "The name of the EKS node group IAM role"
  type        = string
}

variable "eks_nodegroup_instance_profile_name" {
  description = "The name of the EKS node group instance profile"
  type        = string
}

