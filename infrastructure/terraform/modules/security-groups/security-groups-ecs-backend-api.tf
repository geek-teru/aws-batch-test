resource "aws_security_group" "batch" {
  name   = "${var.env}-${var.sys_name}-batch-sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.env}-${var.sys_name}-batch-sg"
    Environment = var.env
  }
}

resource "aws_vpc_security_group_egress_rule" "batch_egress" {
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.batch.id
}
