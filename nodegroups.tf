resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = format("%s-nodegroup", var.name)
  node_role_arn   = aws_iam_role.nodegroups_role.arn

  subnet_ids = var.private_subnets

  scaling_config {
    max_size     = 10
    desired_size = 3
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = var.workload_nodegroup_flavors

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  tags = {
    "k8s.io/cluster-autoscaler/enabled"                  = "true",
    format("k8s.io/cluster-autoscaler/%s-eks", var.name) = "true"
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodegroups_role_attachment_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodegroups_role_attachment_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodegroups_role_attachment_AmazonEC2ContainerRegistryReadOnly,

    kubernetes_config_map.aws_auth
  ]
}