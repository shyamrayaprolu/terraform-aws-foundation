/**
 * ## Single Port Security Group Rule
 *
 * Create an `aws_security_group_rule` to allow ingress on some port.
 *
 * TODO: support both TCP and UDP, use count to enable/disable.
 *
 */

variable "security_group_id" {
  description = "security group to attach the ingress rules to"
  type        = string
}

variable "source_security_group_id" {
  type        = string
  description = "The security group id to allow access from. Cannot be specified with cidr_blocks and self."
  default     = ""
}

variable "cidr_blocks" {
  description = "List of CIDR blocks to allow access from. Cannot be specified with source_security_group_id."
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Use this string to add a description for the SG rule"
  type        = string
}

variable "port" {
  description = "The port to open"
  type        = string
}

variable "tcp" {
  description = "true/false to enables the tcp ingress"
  default     = "true"
  type        = string
}

variable "udp" {
  description = "true/false to enables the udp ingress"
  default     = "false"
  type        = string
}

locals {
  tcp       = "${var.tcp ? 1 : 0}"
  udp       = "${var.udp ? 1 : 0}"
  by_cidr   = length(var.cidr_blocks) == 0 ? 0 : 1
  by_src_sg = var.source_security_group_id == "" ? 0 : 1
}

# ingress rule for tcp, if enabled
resource "aws_security_group_rule" "tcp_ingress_cidr" {
  count             = local.tcp * local.by_cidr
  type              = "ingress"
  description       = "${var.description} (tcp)"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  security_group_id = var.security_group_id
  cidr_blocks       = var.cidr_blocks
}

# ingress rule for udp, if enabled
resource "aws_security_group_rule" "udp_ingress_cidr" {
  count             = local.udp * local.by_cidr
  type              = "ingress"
  description       = "${var.description} (udp)"
  from_port         = var.port
  to_port           = var.port
  protocol          = "udp"
  security_group_id = var.security_group_id
  cidr_blocks       = var.cidr_blocks
}

# ingress rule for tcp, if enabled
resource "aws_security_group_rule" "tcp_ingress_src_sg" {
  count                    = local.tcp * local.by_src_sg
  type                     = "ingress"
  description              = "${var.description} (tcp)"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  security_group_id        = var.security_group_id
  source_security_group_id = var.source_security_group_id
}

# ingress rule for udp, if enabled
resource "aws_security_group_rule" "udp_ingress_src_sg" {
  count                    = local.udp * local.by_src_sg
  type                     = "ingress"
  description              = "${var.description} (udp)"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "udp"
  security_group_id        = var.security_group_id
  source_security_group_id = var.source_security_group_id
}
