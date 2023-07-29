resource "aws_cloudwatch_log_group" "eks_log_groups" {
  name              = format("/aws/eks/%s/cluster", var.name)
  retention_in_days = 7
}