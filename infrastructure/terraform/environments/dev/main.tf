# ------------------------------------------
# Basic Resources
# ------------------------------------------
module "iam" {
  source         = "../../modules/iam"
  env            = var.env
  sys_name       = var.sys_name
  service_name   = var.service_name
  aws_account_id = data.aws_caller_identity.current.account_id
}

module "security_groups" {
  source         = "../../modules/security-groups"
  env            = var.env
  sys_name       = var.sys_name
  service_name   = var.service_name
  aws_account_id = data.aws_caller_identity.current.account_id
  vpc_id         = data.terraform_remote_state.cmn_vpc.outputs.vpc.cmn_vpc.id
}


# ------------------------------------------
# Batch Resources
# ------------------------------------------
module "batch" {
  source         = "../../modules/batch"
  env            = var.env
  sys_name       = var.sys_name
  service_name   = var.service_name
  aws_account_id = data.aws_caller_identity.current.account_id

  # IAM Role
  instance_role_name     = module.iam.batch_instance_role_name
  batch_service_role_arn = module.iam.batch_service_role_arn

  # Network
  subnet_ids         = data.terraform_remote_state.cmn_vpc.outputs.vpc.cmn_vpc_priv_subnet_ids
  security_group_ids = [module.security_groups.batch_sg_id]

}
