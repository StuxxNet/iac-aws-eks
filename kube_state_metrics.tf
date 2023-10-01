resource "helm_release" "kubernetes_metrics_server" {
  name       = "metrics-server"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  version    = "3.11.0"

  depends_on = [
    aws_eks_addon.cni,
    aws_eks_addon.kube_proxy,
    aws_eks_addon.core_dns
  ]
}