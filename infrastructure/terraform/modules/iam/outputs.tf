output "batch_instance_role_arn" {
  value = aws_iam_role.batch_instance_role.arn
}

output "batch_instance_role_name" {
  value = aws_iam_role.batch_instance_role.name
}

output "batch_job_role_arn" {
  value = aws_iam_role.batch_job_role.arn
}

output "batch_service_role_arn" {
  value = aws_iam_role.batch_service_role.arn
}
