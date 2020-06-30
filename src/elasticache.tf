resource "aws_elasticache_cluster" "redis" {
  count                = var.create_elasticache_redis_node ? 1 : 0
  cluster_id           = var.stack_identifier
  engine               = "redis"
  node_type            = var.elasticache_redis_node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.4"
  port                 = 6379

  security_group_ids = [module.vpc.default_security_group_id]
  subnet_group_name = aws_elasticache_subnet_group.redis[0].name

  tags = local.tags
}

resource "aws_elasticache_subnet_group" "redis" {
  count      = var.create_elasticache_redis_node ? 1 : 0
  name       = var.stack_identifier
  subnet_ids = [element(module.vpc.public_subnets, 0)]

  depends_on = [
    aws_iam_service_linked_role.elasticache[0]
  ]
}

resource "aws_iam_service_linked_role" "elasticache" {
  count            = var.create_elasticache_iam_service_linked_role && var.create_elasticache_redis_node ? 1 : 0
  aws_service_name = "elasticache.amazonaws.com"
}

output "redis_cache_nodes" {
  description = "Connection info for the AWS Elasticache Redis nodes."
  value = aws_elasticache_cluster.redis.*.cache_nodes
}