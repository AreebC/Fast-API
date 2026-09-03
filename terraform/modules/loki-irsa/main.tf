data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "loki_s3" {
  name        = "${var.project_name}-LokiS3AccessPolicy"
  description = "Allows Loki to access its S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = [
          for bucket in var.bucket_names :
          "arn:aws:s3:::${bucket}"
        ]
      },
      {
        Effect = "Allow"

        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]

        Resource = [
          for bucket in var.bucket_names :
          "arn:aws:s3:::${bucket}/*"
        ]
      }
    ]
  })
}


resource "aws_iam_role" "loki_irsa" {
  name = "${var.project_name}-LokiIRSA"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.eks_OIDC}"
      }

      Action = "sts:AssumeRoleWithWebIdentity"

      Condition = {
        StringEquals = {
          "${var.eks_OIDC}:sub" = "system:serviceaccount:${var.loki_namespace}:${var.service_account_name}"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "loki_attach" {
  role       = aws_iam_role.loki_irsa.name
  policy_arn = aws_iam_policy.loki_s3.arn
}

resource "kubernetes_service_account_v1" "loki" {
  metadata {
    name      = var.service_account_name
    namespace = var.loki_namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.loki_irsa.arn
    }
  }
}