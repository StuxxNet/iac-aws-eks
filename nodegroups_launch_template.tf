resource "aws_security_group" "sg_nodes" {
  name        = format("%s-cluster-nodes-sg", var.name)
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "sg_nodes_outbound" {
  type              = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_nodes.id
}

resource "aws_security_group_rule" "sg_nodes_inbound_tcp" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_nodes.id
}

resource "aws_launch_template" "nodes" {
  name = format("%s-nodes-launch-template", var.name)

  vpc_security_group_ids = [
    aws_security_group.sg_nodes.id,
    aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  ]

}