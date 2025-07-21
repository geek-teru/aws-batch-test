resource "aws_batch_compute_environment" "batch_fargate" {
  compute_environment_name = "${var.env}-${var.sys_name}-batch-compute-fargate"
  type                     = "MANAGED"
  state                    = "ENABLED"
  service_role             = var.batch_service_role_arn

  compute_resources {
    type      = "FARGATE"
    max_vcpus = 16

    subnets            = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  tags = {
    Env = var.env
  }
}

resource "aws_batch_job_queue" "queue_fargate" {
  name     = "${var.env}-${var.sys_name}-batch-job-queue-fargate"
  state    = "ENABLED"
  priority = 1

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.batch_fargate.arn
  }
}
