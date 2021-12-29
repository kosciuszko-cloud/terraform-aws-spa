module vpc {
  source = "kosciuszko-cloud/vpc/aws"

  env        = var.env
  region     = var.region
  azs        = var.vpc_azs
  private_sn = var.vpc_private_sn
  octet2     = var.vpc_octet2
}
