output "cluster_name" {
    description = "The name of the EKS cluster"
    value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
    description = "The endpoint of the EKS cluster"
    value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority_data" {
    description = "The certificate authority data for the EKS cluster"
    value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "node_group_name" {
    description = "The name of the EKS node group"
    value       = aws_eks_node_group.eks_nodegroup.node_group_name
}

output "oidc_issuer_url" {
    description = "The OIDC issuer URL for the EKS cluster"
    value       = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}