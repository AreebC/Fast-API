output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_hostpath" {
  value = local.oidc_hostpath
}