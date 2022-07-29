output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_dmz_az1_id" {
  value = aws_subnet.subnet_dmz_az1.id
}

output "subnet_dmz_az2_id" {
  value = aws_subnet.subnet_dmz_az2.id
}

output "subnet_priv_az1_id" {
  value = aws_subnet.subnet_priv_az1.id
}

output "subnet_priv_az2_id" {
  value = aws_subnet.subnet_priv_az2.id
}

output "eip_az1_ip" {
  value = var.discriminat ? aws_eip.discriminat_az1.*.public_ip[0] : aws_eip.eip_az1.*.public_ip[0]
}

output "eip_az2_ip" {
  value = var.discriminat ? aws_eip.discriminat_az2.*.public_ip[0] : aws_eip.eip_az2.*.public_ip[0]
}
