# iam_role
resource "aws_iam_role" "batch_job_role" {
  name = "${var.env}-${var.sys_name}-${var.service_name}-job-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
