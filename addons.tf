resource "aws_eks_addon" "cni" {
  cluster_name      = aws_eks_cluster.this.name
  addon_name        = "vpc-cni"

  addon_version     = "v1.13.3-eksbuild.1"
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    kubernetes_config_map.aws_auth
  ]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = aws_eks_cluster.this.name
  addon_name        = "kube-proxy"

  addon_version     = "v1.25.11-eksbuild.2"
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    kubernetes_config_map.aws_auth
  ]
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name      = aws_eks_cluster.this.name
  addon_name        = "aws-ebs-csi-driver"

  addon_version     = "v1.21.0-eksbuild.1"
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    kubernetes_config_map.aws_auth
  ]
}

resource "aws_eks_addon" "core_dns" {
  cluster_name      = aws_eks_cluster.this.name
  addon_name        = "coredns"

  addon_version     = "v1.9.3-eksbuild.5"
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    kubernetes_config_map.aws_auth
  ]
}