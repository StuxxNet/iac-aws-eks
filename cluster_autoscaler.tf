data "aws_region" "current" {}

resource "helm_release" "cluster_autoscaler" {
  name       = "autoscaler"
  namespace  = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  create_namespace = true

  set {
    name  = "autoDiscovery.clusterName"
    value = format("%s-eks", var.name)
  }

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.eks_cluster_autoscaler_role.arn
  }

  depends_on = [
    aws_eks_addon.cni,
    aws_eks_addon.kube_proxy,
    aws_eks_addon.core_dns,

    aws_iam_role_policy_attachment.autoscaler_role_attachment
  ]
}