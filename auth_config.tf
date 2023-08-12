resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<YAML
- rolearn: ${aws_iam_role.nodegroups_role.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
  - system:bootstrappers
  - system:nodes
  - system:node-proxier
- rolearn: arn:aws:iam::851706628945:role/CrossRoleDevOpsEngineers
  username: cluster-admin
  groups:
  - system:masters
YAML
  }
}