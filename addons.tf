resource "aws_eks_addon" "cni" {
  cluster_name      = aws_eks_cluster.this.name
  addon_name        = "vpc-cni"

  addon_version     = "v1.13.3-eksbuild.1"
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    kubernetes_config_map.aws_auth
  ]

}