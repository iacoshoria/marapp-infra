variable "stack_identifier" {
  description = "Application and infrastructure stack identifier. Prepended to provisioned resources"
  type        = string
  default     = "marapp"
}

variable "environment_name" {
  description = "Application and infrastructure environment name. Used to tag resources as belonging to the environment. (i.e. staging/rc/prod)"
  type        = string
}

# AWS-specific vars
variable "aws_region" {
  description = "AWS region into which to provision resources (i.e. us-east-1/us-west-1)"
  type        = string
}

variable "vpc_cidr" {
  description = "Addressable CIDR of the AWS VPC."
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones into which to provision subnets"
  type        = list
}

variable "public_subnet_cidrs" {
  description = "Addressable CIDRs for the availability zones' subnets"
  type        = list
}

variable "private_subnet_cidrs" {
  description = "Addressable CIDRs for the availability zones' private subnets"
  type        = list
}

# MongoDB Atlas 
variable "create_mongodb_atlas_resources" {
  description = "Set to `true` to create MongoDB Atlas resources."
  type        = bool
  default     = false
}

variable "mongodb_atlas_public_key" {
  description = "Public key used to access the MongoDB Atlas API. To be used in conjunction with the `create_mongodb_atlas_resources` variable"
  type        = string
  default     = ""
}

variable "mongodb_atlas_private_key" {
  description = "Private key used to access the MongoDB Atlas API. To be used in conjunction with the `create_mongodb_atlas_resources` variable"
  type        = string
  default     = ""
}

variable "mongodb_atlas_organization_id" {
  description = "MongoDB Atlas organization. To be used in conjunction with the `create_mongodb_atlas_resources` variable"
  type        = string
  default     = ""
}

variable "mongodb_atlas_project_name" {
  description = "MongoDB Atlas project name. To be used in conjunction with the `create_mongodb_atlas_resources` variable"
  type        = string
  default     = ""
}

variable "mongodb_atlas_cluster_disk_size" {
  description = "Disk size for the MongoDB Atlas cluster. To be used in conjunction with the `create_mongodb_atlas_resources` variable"
  type        = number
  default     = 210
}

variable "mongodb_atlas_cluster_disk_iops" {
  description = "Provisioned IOPS for the MongoDB Atlas cluster. To be used in conjunction with the `create_mongodb_atlas_resources` variable"
  type        = number
  default     = 630
}

variable "mongodb_atlas_cluster_instance_size" {
  description = "Instance size for the MongoDB Atlas cluster. To be used in conjunction with the `create_mongodb_atlas_resources` variable. Documented under `providerSettings.instanceSizeName`: https://docs.atlas.mongodb.com/reference/api/clusters-create-one/"
  type        = string
  default     = "M40"
}

variable "mongodb_atlas_cluster_aws_region" {
  description = "AWS Region for the MongoDB Atlas cluster. To be used in conjunction with the `create_mongodb_atlas_resources` variable. Must corelate with the `aws_region` variable. . Documented under `providerSettings.regionName`: https://docs.atlas.mongodb.com/reference/api/clusters-create-one/"
  type        = string
  default     = "US_EAST_1"
}

# Elasticache/Redis
variable "create_elasticache_iam_service_linked_role" {
  description = "Set to `true` to create an AWS IAM Service Linked Role for Elasticache. Leave `false` if you want to use your own Redis node _or_ an IAM Service Linked Role already exists for Elasticache"
  type        = bool
  default     = false
}

variable "create_elasticache_redis_node" {
  description = "Set to `true` to create an AWS Elasticache Redis cluster. Leave `false` if you want to use your own Redis node"
  type        = bool
  default     = false
}

variable "elasticache_redis_node_type" {
  description = "Node type of the AWS Elasticache Redis cluster. To be used in conjunction with the `create_elasticache_redis_node` variable. Documented here: https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/CacheNodes.SupportedTypes.html"
  type        = string
  default     = "cache.t2.small"
}

# Elasticsearch
variable "create_elasticsearch_iam_service_linked_role" {
  description = "Set to `true` to create an AWS IAM Service Linked Role for Elasticsearch. Leave `false` if you want to use your own Elasticsearch cluster _or_ an IAM Service Linked Role already exists for Elasticache"
  type        = bool
  default     = false
}

variable "create_elasticsearch_cluster" {
  description = "Set to `true` to create an AWS Elasticsearch 6.0 cluster. Leave `false` if you want to use your own Elasticsearch 6.0 node"
  type        = bool
  default     = false
}

variable "elasticsearch_instance_type" {
  description = "Instance type of the AWS Elasticsearch cluster. To be used in conjunction with the `create_elasticsearch_cluster` variable. Documented here: https://aws.amazon.com/elasticsearch-service/pricing/"
  type        = string
  default     = "t2.small.elasticsearch"
}

variable "elasticsearch_instance_count" {
  description = "Number of instances in the AWS Elasticsearch cluster. To be used in conjunction with the `create_elasticsearch_cluster` variable."
  type        = number
  default     = 1
}

variable "elasticsearch_instance_disk_volume_size" {
  description = "Disk volume size of the instances in the AWS Elasticsearch cluster. To be used in conjunction with the `create_elasticsearch_cluster` variable."
  type        = number
  default     = 20
}
