output "asg_name" {
  value       = module.server.name
  description = "`name` exported from the Server `aws_autoscaling_group`"
}

output "asg_iam_role_name" {
  value       = module.instance_profile.iam_role_name
  description = "`name` exported from the Service Data `aws_iam_role`"
}

output "eip_address" {
	value = var.assign_eip ? aws_eip.eip.*[0].public_ip : ""
}
