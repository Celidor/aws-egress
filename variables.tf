variable "project" {
  description = "abbreviation for the project, forms first part of resource names"
  default     = "aws-egress"
}

variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "az1" {
  default = "eu-west-1a"
}

variable "az2" {
  default = "eu-west-1b"
}

variable "tags" {
  type        = map(string)
  description = "Optional Tags"
  default     = {}
}

variable "vpc_cidr" {
  description = "vpc CIDR range"
  default     = "172.16.0.0/16"
}

variable "subnet_dmz_cidr_az1" {
  description = "AZ1 DMZ subnet"
  default     = "172.16.1.0/24"
}
variable "subnet_dmz_cidr_az2" {
  description = "AZ2 DMZ subnet"
  default     = "172.16.128.0/24"
}

variable "subnet_priv_cidr_az1" {
  description = "AZ1 private subnet"
  default     = "172.16.2.0/24"
}

variable "subnet_priv_cidr_az2" {
  description = "AZ2 private subnet"
  default     = "172.16.129.0/24"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "amazon_linux_major_version" {
  description = "major version of Amazon Linux"
  default     = "5.10-hvm-2.0"
}

variable "discriminat" {
  default = false
}

variable "discriminat_version" {
  default = "2.8.0"
}

variable "compute_az1_ip" {
  description = "fixed private IP address for Compute in AZ1"
  default     = "172.16.2.10"
}

variable "compute_az2_ip" {
  description = "fixed private IP address for Compute in AZ2"
  default     = "172.16.129.10"
}

variable "log_bucket" {
  description = "Session Manager log bucket"
  default     = "celidor-sessionmanager"
}