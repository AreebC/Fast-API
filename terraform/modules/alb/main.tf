data "aws_caller_identity" "current" {}

resource "aws_iam_role" "alb_irsa" {
  name = "alb-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.eks_OIDC}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${var.eks_OIDC}:sub" = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
            "${var.eks_OIDC}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "alb_controller_policy" {
  name        = "AWSLoadBalancerControllerPolicy"
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = file("${path.module}/iam-policy.json")
}

resource "aws_iam_role_policy_attachment" "alb_irsa_attachment" {
  role       = aws_iam_role.alb_irsa.name
  policy_arn = aws_iam_policy.alb_controller_policy.arn
}

resource "kubernetes_service_account" "alb_sa" {
  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.alb_irsa.arn
    }
  }
}