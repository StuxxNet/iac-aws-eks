resource "aws_eks_cluster" "cluster" {
  name = format("%s-eks", var.name)

  version = var.eks_version

  role_arn = aws_iam_role.controlplane_role.arn

  vpc_config {
    subnet_ids = var.private_subnets
  }

  encryption_config {
    provider {
      key_arn = aws_kms_key.eks_secrets_encryption.arn
    }
    resources = ["secrets"]
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  depends_on = [
    aws_iam_role_policy_attachment.controlplane_role_attachment_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.controlplane_role_attachment_AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.eks_log_groups
  ]
}