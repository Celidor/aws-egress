resource "aws_security_group" "compute" {
  name   = "${var.project}-${local.env}-compute"
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-compute"
    },
  )
}

resource "aws_security_group_rule" "repos" {
  security_group_id = aws_security_group.compute.id

  type        = "egress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  # Use of FQDNs list formatted into the expected syntax.
  description = local.discriminat_repos
}

resource "aws_security_group_rule" "aws" {
  security_group_id = aws_security_group.compute.id

  type        = "egress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  # Use of FQDNs list formatted into the expected syntax.
  description = local.discriminat_aws
}

resource "aws_security_group_rule" "logging" {
  security_group_id = aws_security_group.compute.id

  type      = "egress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  # AWS does not allow multiple Rules with the same protocol/port/cidr combination, so
  # we just choose a different network prefix to get around that. That is, if /0 had already been
  # used, we'll pick /1 or any value up to /32
  cidr_blocks = ["0.0.0.0/1"]

  # Use of FQDNs list formatted into the expected syntax.
  description = local.discriminat_logging
}

resource "aws_security_group_rule" "application" {
  security_group_id = aws_security_group.compute.id

  type      = "egress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  # AWS does not allow multiple Rules with the same protocol/port/cidr combination, so
  # we just choose a different network prefix to get around that. That is, if /0 had already been
  # used, we'll pick /1 or any value up to /32
  cidr_blocks = ["0.0.0.0/2"]

  # Use of FQDNs list formatted into the expected syntax.
  description = local.discriminat_application
}
