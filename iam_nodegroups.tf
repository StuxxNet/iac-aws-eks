data "aws_iam_policy_document" "nodegroups_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]

  }
}

resource "aws_iam_policy" "ebs_csi_driver_policy" {
  name        = "eks-csi-driver-policy"
  description = "Policy required to enable K8S to spin it's load-balancers"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Sid" : "VisualEditor0",
      "Effect" : "Allow",
      "Action" : [
        "ec2:CreateVolume",
        "ec2:DeleteVolume",
        "ec2:DetachVolume",
        "ec2:AttachVolume",
        "ec2:DescribeInstances",
        "ec2:CreateTags",
        "ec2:DeleteTags",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes"
      ],
      "Resource" : "*"
    }]
  })
}

resource "aws_iam_role" "nodegroups_role" {
  name               = format("%s-nodegroups-role", var.name)
  assume_role_policy = data.aws_iam_policy_document.nodegroups_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attachment" {
  policy_arn = aws_iam_policy.ebs_csi_driver_policy.arn
  role       = aws_iam_role.nodegroups_role.name
}

resource "aws_iam_role_policy_attachment" "nodegroups_role_attachment_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodegroups_role.name
}

resource "aws_iam_role_policy_attachment" "nodegroups_role_attachment_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodegroups_role.name
}

resource "aws_iam_role_policy_attachment" "nodegroups_role_attachment_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodegroups_role.name
}