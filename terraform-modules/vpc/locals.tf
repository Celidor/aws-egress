locals {
  env = lower(terraform.workspace)

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}"
    },
  )

  vpc_endpoints = [
    "ec2",
    "ec2messages",
    "kms",
    "s3",
    "ssm",
    "ssmmessages",
  ]
}