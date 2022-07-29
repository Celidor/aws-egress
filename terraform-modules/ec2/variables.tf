variable "project" {
  description = "The name of the project"
}

variable "region" {
  description = "AWS region"
}

variable "tags" {
  description = "Optional tags"
}

variable "image" {
  description = "Image AMI"
}

variable "instance_type" {
  description = "virtual machine size"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_dmz_az1_id" {
  description = "VPC subnet used by Bastion"
}

variable "subnet_priv_az1_id" {
  description = "VPC subnet used by private compute instance in AZ1"
}

variable "subnet_priv_az2_id" {
  description = "VPC subnet used by private compute instance in AZ2"
}

variable "compute_az1_ip" {
  description = "fixed private IP address for Compute in AZ1"
}

variable "compute_az2_ip" {
  description = "fixed private IP address for Compute in AZ2"
}

variable "elastic_ips" {
  description = "Elastic IP addresses of NAT Gateways or Discriminat"
}

variable "log_bucket" {
  description = "S3 log bucket"
}