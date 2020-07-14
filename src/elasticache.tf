/*
  Copyright 2018-2020 National Geographic Society

  Use of this software does not constitute endorsement by National Geographic
  Society (NGS). The NGS name and NGS logo may not be used for any purpose without
  written permission from NGS.

  Licensed under the Apache License, Version 2.0 (the "License"); you may not use
  this file except in compliance with the License. You may obtain a copy of the
  License at

      https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software distributed
  under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
  CONDITIONS OF ANY KIND, either express or implied. See the License for the
  specific language governing permissions and limitations under the License.
*/

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