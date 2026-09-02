locals {
  oidc_hostpath = replace(var.eks_oidc_url, "https://", "")
}

resource "aws_iam_openid_connect_provider" "eks" {
  url = var.eks_oidc_url

  client_id_list = [
    "sts.amazonaws.com"
  ]
}