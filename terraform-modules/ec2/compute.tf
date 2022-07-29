resource "aws_network_interface" "compute_az1" {
  subnet_id   = var.subnet_priv_az1_id
  private_ips = [var.compute_az1_ip]

  security_groups = [aws_security_group.compute.id]

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-compute-az1"
    },
  )

}

resource "aws_instance" "compute_az1" {
  ami                  = var.image
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm.id

  network_interface {
    network_interface_id = aws_network_interface.compute_az1.id
    device_index         = 0
  }

  monitoring = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-compute-az1"
    },
  )
}

resource "aws_network_interface" "compute_az2" {
  subnet_id   = var.subnet_priv_az2_id
  private_ips = [var.compute_az2_ip]

  security_groups = [aws_security_group.compute.id]

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-compute-az2"
    },
  )

}

resource "aws_instance" "compute_az2" {
  ami                  = var.image
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm.id

  network_interface {
    network_interface_id = aws_network_interface.compute_az2.id
    device_index         = 0
  }

  monitoring = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-compute-az2"
    },
  )
}
