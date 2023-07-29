resource "aws_eks_cluster" "this" {
  name = format("%s-eks", var.name)

  version = var.eks_version

  role_arn = aws_iam_role.controlplane_role.arn

  vpc_config {
    subnet_ids = var.subnets
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.controlplane_role_attachment_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.controlplane_role_attachment_AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.eks_log_groups
  ]
}