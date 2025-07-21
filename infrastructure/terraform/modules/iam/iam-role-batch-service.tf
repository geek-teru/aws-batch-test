# iam_policy
resource "aws_iam_policy" "batch_service_policy" {
  name   = "${var.env}-${var.sys_name}-service-policy"
  policy = file("${path.module}/policies/batch-service.json")
}

# iam_role
resource "aws_iam_role" "batch_service_role" {
  name = "${var.env}-${var.sys_name}-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "batch.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "batch_service_policy_attachment" {
  role       = aws_iam_role.batch_service_role.name
  policy_arn = aws_iam_policy.batch_service_policy.arn
}
