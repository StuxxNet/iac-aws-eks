resource "aws_iam_policy" "eks_cluster_autoscaler_policy" {
  name        = "eks-autoscaling-controller-policy"
  description = "Policy required to enable K8S to scale by creating new nodes"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeScalingActivities",
          "autoscaling:DescribeTags",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplateVersions"
        ],
        "Resource" : ["*"]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeImages",
          "ec2:GetInstanceTypesFromInstanceRequirements",
          "eks:DescribeNodegroup"
        ],
        "Resource" : ["*"]
      }
    ]
  })
}

data "aws_iam_policy_document" "eks_cluster_autoscaler_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:cluster-autoscaler:autoscaler-aws-cluster-autoscaler"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_cluster_autoscaler_role" {
  name               = format("%s-autoscaling-controller-role", var.name)
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_autoscaler_assume_role.json
}

resource "aws_iam_role_policy_attachment" "autoscaler_role_attachment" {
  policy_arn = aws_iam_policy.eks_cluster_autoscaler_policy.arn
  role       = aws_iam_role.eks_cluster_autoscaler_role.name
}
