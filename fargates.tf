resource "aws_ecs_cluster" "api_cluster" {
  name = "${var.env}_api_cluster"

  capacity_providers = ["FARGATE"]

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

data aws_subnet_ids public {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "*_public_*"
  }

  depends_on = [
    module.vpc
  ]
}

data aws_subnet_ids private {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "*_api_*"
  }

  depends_on = [
    module.vpc
  ]
}

module "ecs_fargate" {
  source = "kosciuszko-cloud/fargate/aws"

  env          = var.env
  region       = var.region
  task_image   = "${aws_ecr_repository.ecr.repository_url}:latest"
  task_cpu     = 256
  task_memory  = 512
  task_subnets = data.aws_subnet_ids.private.ids
  alb_subnets  = data.aws_subnet_ids.public.ids
  cluster_id   = aws_ecs_cluster.api_cluster.id
  vpc_id       = module.vpc.vpc_id
  internal_sg  = module.vpc.internal_sg_id
  external_sg  = module.vpc.external_sg_id
}
