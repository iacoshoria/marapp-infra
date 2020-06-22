aws_region       = "us-east-1"
stack_identifier = "marapp"
environment_name = "sandbox"

vpc_cidr = "10.0.0.0/16"
availability_zones = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
  "us-east-1d",
  "us-east-1e",
  "us-east-1f"
]
public_subnet_cidrs = [
  "10.0.0.0/19",
  "10.0.32.0/19",
  "10.0.64.0/19",
  "10.0.96.0/19",
  "10.0.128.0/19",
  "10.0.160.0/19"
]
private_subnet_cidrs = [
  "10.0.192.0/21",
  "10.0.200.0/21",
  "10.0.208.0/21",
  "10.0.216.0/21",
  "10.0.224.0/21",
  "10.0.232.0/21"
]

create_elasticache_iam_service_linked_role = true
create_elasticache_redis_node              = true
elasticache_redis_node_type                = "cache.t2.small"

create_elasticsearch_iam_service_linked_role = true
create_elasticsearch_cluster                 = true
elasticsearch_instance_type                  = "t2.small.elasticsearch"
elasticsearch_instance_count                 = 1
elasticsearch_instance_disk_volume_size      = 20

create_mongodb_atlas_resources = true
mongodb_atlas_public_key       = ""
mongodb_atlas_private_key      = ""
mongodb_atlas_organization_id  = ""
mongodb_atlas_project_name     = ""