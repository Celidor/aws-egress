locals {
  env         = lower(terraform.workspace)
  name        = "${var.project}-${local.env}"
  elastic_ips = ["${element(var.elastic_ips, 0)}/32", "${element(var.elastic_ips, 1)}/32"]
  bucket_name = var.log_bucket
}

locals {
  fqdns_repos = [
    "github.com"
  ]
  fqdns_aws = [
    "ec2-instance-connect.${var.region}.amazonaws.com",
    "ec2messages.${var.region}.amazonaws.com",
    "kms.${var.region}.amazonaws.com",
    "ssm.${var.region}.amazonaws.com",
    "ssmmessages.${var.region}.amazonaws.com",
    "amazonlinux-2-repos-${var.region}.s3.${var.region}.amazonaws.com"
  ]
  fqdns_logging = [
    "${local.bucket_name}.s3.${var.region}.amazonaws.com",
    "logs.${var.region}.amazonaws.com"
  ]
  fqdns_application = [
    "ubuntu.com",
    "centos.org"
  ]
  discriminat_repos       = format("discriminat:ssh:%s", join(",", local.fqdns_repos))
  discriminat_aws         = format("discriminat:tls:%s", join(",", local.fqdns_aws))
  discriminat_logging     = format("discriminat:tls:%s", join(",", local.fqdns_logging))
  discriminat_application = format("discriminat:tls:%s", join(",", local.fqdns_application))
}
