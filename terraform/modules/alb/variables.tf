variable "eks_OIDC" {
  description = "The OIDC provider URL for the EKS cluster"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace to deploy the AWS Load Balancer Controller"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "region" {
  description = "The AWS region where the EKS cluster is deployed"
  type        = string
}

variable "service_account_name" {
  description = "The name of the Kubernetes service account to use for the AWS Load Balancer Controller"
  type        = string
}

variable "eks_oidc_provider_arn" {
  type = string
}

variable "eks_oidc_hostpath" {
  type = string
}
