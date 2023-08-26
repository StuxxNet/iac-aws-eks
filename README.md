# Terraform EKS Module

## ToDos

- [ ] Review the ingress loadbalancer creation: Make it external and NLB
- [ ] Add tags to all the resources
- [ ] Add variables for hard-coded content
- [ ] Refactor repetitive code sections to use inline loops (addons, node-groups)
- [ ] Add a new nodegroup for ingress and taint to reserve the instances
- [ ] Add test cluster auto-scaler
- [ ] Enhance auth_config to be able to receive multiple roles
- [ ] Make it a module and move the provider configuration to the readme to explain how to use the module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.10.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.11.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.10.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.11.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.22.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.eks_log_groups](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_addon.cni](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/eks_addon) | resource |
| [aws_eks_addon.core_dns](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/eks_addon) | resource |
| [aws_eks_addon.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/eks_addon) | resource |
| [aws_eks_addon.kube_proxy](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.nodes](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.oidc](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.aws_loadbalancer_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.controlplane_role](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_role) | resource |
| [aws_iam_role.loadbalancer_controller_role](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_role) | resource |
| [aws_iam_role.nodegroups_role](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.controlplane_role_attachment_AmazonEKSClusterPolicy](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.controlplane_role_attachment_AmazonEKSVPCResourceController](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.loadbalancer_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.nodegroups_role_attachment_AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.nodegroups_role_attachment_AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.nodegroups_role_attachment_AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.eks_secrets_encryption_alias](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.eks_secrets_encryption](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/resources/kms_key) | resource |
| [helm_release.aws_loadbalancer_controller](https://registry.terraform.io/providers/hashicorp/helm/2.11.0/docs/resources/release) | resource |
| [helm_release.nginx_ingress_controller](https://registry.terraform.io/providers/hashicorp/helm/2.11.0/docs/resources/release) | resource |
| [kubernetes_config_map.aws_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/config_map) | resource |
| [kubernetes_service_account.loadbalancer_controller_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/service_account) | resource |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_load_balancer_controller_assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.nodegroups_assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.10.0/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | Cluster version | `string` | `"1.25"` | no |
| <a name="input_name"></a> [name](#input\_name) | The default name for the majority of resources | `string` | `"devops"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of subnets where cluster will spin it's nodes | `list(string)` | <pre>[<br>  "subnet-07679ba9b8dee988f",<br>  "subnet-0127fe1a3ce8e320a",<br>  "subnet-02655d15792b5a3d6"<br>]</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC | `string` | `"vpc-0d7ee178466caab08"` | no |
| <a name="input_workload_nodegroup_flavors"></a> [workload\_nodegroup\_flavors](#input\_workload\_nodegroup\_flavors) | Flavor of of the nodes that composes the nodegroup | `list(string)` | <pre>[<br>  "t3.large",<br>  "t3.xlarge"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_kubeconfig-certificate-authority-data"></a> [kubeconfig-certificate-authority-data](#output\_kubeconfig-certificate-authority-data) | n/a |
