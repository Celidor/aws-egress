variable "project" {
  description = "The name of the project"
}

variable "region" {
  description = "AWS region"
}

variable "tags" {
  description = "Optional tags"
}

variable "vpc_cidr" {
  description = "VPC CIDR range"
}

variable "subnet_dmz_cidr_az1" {
  description = "AZ1 DMZ subnet"
}

variable "subnet_dmz_cidr_az2" {
  description = "AZ2 DMZ subnet"
}

variable "subnet_priv_cidr_az1" {
  description = "AZ1 private subnet"
}

variable "subnet_priv_cidr_az2" {
  description = "AZ2 private subnet"
}

variable "az1" {
  description = "1st availability zone"
}

variable "az2" {
  default = "2nd availability zone"
}

variable "flow_log_retention_in_days" {
  description = "Days to retain Flow Logs in CloudWatch"
  default     = "30"
}

variable "discriminat" {
  description = "Whether to install Discriminat, if set to false, NAT Gateways will be created"
}

variable "discriminat_az1_eni" {
  description = "Discriminat network interface in AZ1"
}

variable "discriminat_az2_eni" {
  description = "Discriminat network interface in AZ2"
}