data "aws_iam_policy_document" "alb_irsa_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        var.eks_oidc_provider_arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.eks_oidc_hostpath}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.service_account_name}"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.eks_oidc_hostpath}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }
  }
}


resource "aws_iam_role" "alb_irsa" {
  name = "alb-irsa-role"

  assume_role_policy = data.aws_iam_policy_document.alb_irsa_assume_role.json
}


resource "aws_iam_policy" "alb_controller_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  description = "IAM policy for the AWS Load Balancer Controller"

  policy = file("${path.module}/iam-policy.json")
}


resource "aws_iam_role_policy_attachment" "alb_controller_policy_attachment" {
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