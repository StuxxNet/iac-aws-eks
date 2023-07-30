resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = format("%s-nodegroup", var.name)
  node_role_arn   = aws_iam_role.nodegroups_role.arn
  subnet_ids      = var.subnets

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = var.workload_nodegroup_flavors

  depends_on = [
    aws_iam_role_policy_attachment.nodegroups_role_attachment_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodegroups_role_attachment_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodegroups_role_attachment_AmazonEC2ContainerRegistryReadOnly,
  ]
}