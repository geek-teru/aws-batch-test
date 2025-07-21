resource "aws_iam_instance_profile" "batch_instance_profile" {
  name = "${var.env}-${var.sys_name}-batch-instance-profile"
  role = var.instance_role_name
}

resource "aws_batch_compute_environment" "batch_ec2" {
  compute_environment_name = "${var.env}-${var.sys_name}-batch-compute-ec2"
  type                     = "MANAGED"
  state                    = "ENABLED"
  service_role             = var.batch_service_role_arn

  compute_resources {
    type                = "EC2"
    allocation_strategy = "BEST_FIT_PROGRESSIVE"
    min_vcpus           = 0   # 最小vCPU数
    max_vcpus           = 100 # 最大vCPU数
    desired_vcpus       = 0   # 初期状態で起動するvCPU数

    instance_type = ["m5.large"]
    instance_role = aws_iam_instance_profile.batch_instance_profile.arn

    subnets            = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  tags = {
    Env = var.env
  }
}

resource "aws_batch_job_queue" "queue_ec2" {
  name     = "${var.env}-${var.sys_name}-batch-job-queue"
  state    = "ENABLED"
  priority = 1

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.batch_ec2.arn
  }
}
