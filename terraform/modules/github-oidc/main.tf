data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}


resource "aws_iam_role" "github_actions_ci_cd" {
  name = "github-actions-ci-cd-role"

  assume_role_policy = jsonencode({
   Version: "2012-10-17",
   Statement: [
    {
      Effect: "Allow",
      Principal: {
        Federated: "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
      },
      Action: "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals: {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
          "token.actions.githubusercontent.com:sub": "repo:AreebC/Fast-API:ref:refs/heads/main"
        }
      }
     }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "terraform_eks-service" {
  role       = aws_iam_role.github_actions_ci_cd.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role_policy_attachment" "terraform_eks" {
  role       = aws_iam_role.github_actions_ci_cd.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "terraform_iam" {
  role       = aws_iam_role.github_actions_ci_cd.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_role_policy_attachment" "terraform_s3" {
  role       = aws_iam_role.github_actions_ci_cd.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  role       = aws_iam_role.github_actions_ci_cd.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "dynamodb_access" {
  role       = aws_iam_role.github_actions_ci_cd.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}