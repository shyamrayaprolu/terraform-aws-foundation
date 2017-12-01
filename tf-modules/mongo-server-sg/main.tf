/**
 * ## MongoDB Server Security Group
 *
 * Security group rules for use with MongoDB servers.
 */

variable "security_group_id" {
  description = "security group to attach the ingress rules to"
}

variable "cidr_blocks" {
  description = "The list of CIDR IP blocks allowed to access mongod"
  type        = "list"
}

variable "description" {
  description = "use this string to generate a description for the SG rules"
  default     = "Allow ingress, mongod's"
}
# Security group for mongod servers
resource "aws_security_group_rule" "mongo_tcp_1" {
  type              = "ingress"
  description       = "${var.description} client port 27017 (TCP)"
  from_port         = "27017"
  to_port           = "27017"
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr_blocks}"]
  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "mongo_tcp_2" {
  type              = "ingress"
  description       = "${var.description} admin port 28017 (TCP)"
  from_port         = "28017"
  to_port           = "28017"
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr_blocks}"]
  security_group_id = "${var.security_group_id}"
}
