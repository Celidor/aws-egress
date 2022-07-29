resource "aws_eip" "eip_az1" {
  count = var.discriminat ? 0 : 1
  vpc   = true
}

resource "aws_eip" "eip_az2" {
  count = var.discriminat ? 0 : 1
  vpc   = true
}

resource "aws_eip" "discriminat_az1" {
  count = var.discriminat ? 1 : 0
  vpc   = true

  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${local.env}-${var.az1}",
      discriminat = "used by DiscrimiNAT"
    },
  )
}

resource "aws_eip" "discriminat_az2" {
  count = var.discriminat ? 1 : 0
  vpc   = true

  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${local.env}-${var.az2}",
      discriminat = "used by DiscrimiNAT"
    },
  )
}

resource "aws_nat_gateway" "natgw_az1" {
  count         = var.discriminat ? 0 : 1
  allocation_id = aws_eip.eip_az1.*.id[0]
  subnet_id     = aws_subnet.subnet_dmz_az1.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-${var.az1}"
    },
  )

}

resource "aws_nat_gateway" "natgw_az2" {
  count         = var.discriminat ? 0 : 1
  allocation_id = aws_eip.eip_az2.*.id[0]
  subnet_id     = aws_subnet.subnet_dmz_az2.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${local.env}-${var.az2}"
    },
  )

}
