resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags
}

resource "aws_internet_gateway" "igw_main" {
  vpc_id = aws_vpc.vpc.id

  tags = local.tags
}

resource "aws_subnet" "subnet_dmz_az1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az1
  cidr_block              = var.subnet_dmz_cidr_az1
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-dmz-${var.az1}"
    },
  )
}

resource "aws_subnet" "subnet_dmz_az2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az2
  cidr_block              = var.subnet_dmz_cidr_az2
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-dmz-${var.az2}"
    },
  )
}

resource "aws_subnet" "subnet_priv_az1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az1
  cidr_block              = var.subnet_priv_cidr_az1
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-private-${var.az1}"
    },
  )
}

resource "aws_subnet" "subnet_priv_az2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.az2
  cidr_block              = var.subnet_priv_cidr_az2
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-private-${var.az2}"
    },
  )
}

resource "aws_security_group" "vpce" {
  name        = "vpce"
  description = "ingress from entire vpc to endpoints for connectivity to it without public ips"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]

    description = "only https standard port needed for apis"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-dmz-${var.az1}"
    },
  )
}

resource "aws_vpc_endpoint" "ec2" {
  for_each = toset(local.vpc_endpoints)

  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.${var.region}.${each.key}"
  vpc_endpoint_type = "Interface"

  subnet_ids = [aws_subnet.subnet_priv_az1.id, aws_subnet.subnet_priv_az2.id]

  security_group_ids = [aws_security_group.vpce.id]

  private_dns_enabled = each.key == "s3" ? false : true

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-dmz-${var.az1}"
    },
  )
}
