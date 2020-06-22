
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> v2.0"

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  name = var.stack_identifier
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs

  tags = local.tags
}

output "vpc_id" {
  description = "Id of the provisioned AWS VPC"
  value = module.vpc.vpc_id
}

output "vpc_subnets" {
  description = "Ids of the public subnets provisioned in the VPC"
  value = module.vpc.public_subnets
}
output "private_vpc_subnets" {
  description = "Ids of the private subnets provisioned in the VPC"
  value = module.vpc.private_subnets
}

output "vpc_security_group" {
  description = "Id of the default security group provisioned for the VPC"
  value = module.vpc.default_security_group_id
}

resource "aws_vpc_endpoint" "mongodb_atlas_vpc_endpoint" {
  count              = var.create_mongodb_atlas_resources ? 1 : 0
  vpc_id             = module.vpc.vpc_id
  service_name       = mongodbatlas_private_endpoint.private_endpoint[0].endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [module.vpc.default_security_group_id]

  tags = local.tags
}