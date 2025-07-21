# iam_role
resource "aws_iam_role" "batch_instance_role" {
  name = "${var.env}-${var.sys_name}-${var.service_name}-instance-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
