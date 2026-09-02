output "eks_cluster_role_arn" {
  description = "The ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_nodegroup_role_arn" {
  description = "The ARN of the EKS node group IAM role"
  value       = aws_iam_role.eks_nodegroup_role.arn
}

output "eks_nodegroup_instance_profile_name" {
  description = "The name of the EKS node group instance profile"
  value       = aws_iam_instance_profile.eks_nodegroup_instance_profile.name
}

output "eks_nodegroup_instance_profile_arn" {
  description = "The ARN of the EKS node group instance profile"
  value       = aws_iam_instance_profile.eks_nodegroup_instance_profile.arn
}

