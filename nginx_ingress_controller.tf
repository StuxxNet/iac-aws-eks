resource "helm_release" "nginx_ingress_controller" {
  name       = "nginx-ingress-controller"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.2.3"

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  depends_on = [
    aws_eks_addon.cni,
    aws_eks_addon.kube_proxy,
    aws_eks_addon.core_dns,

    helm_release.aws_loadbalancer_controller
  ]
}