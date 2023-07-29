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

resource "aws_iam_role" "nodegroups_role" {
  name               = format("%s-nodegroups-role", var.name)
  assume_role_policy = data.aws_iam_policy_document.nodegroups_assume_role.json
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