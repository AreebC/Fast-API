variable "project_name" {
  description = "The name of the project, used for naming resources"
  type        = string
}

variable "eks_OIDC" {
  description = "The OIDC provider URL for the EKS cluster"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace where the service account is located"
  type        = string
}

variable "service_account_name" {
  description = "The name of the Kubernetes service account that will assume the role"
  type        = string
}
