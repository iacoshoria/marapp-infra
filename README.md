## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | ~> 2.0 |
| mongodbatlas | ~> 0.5 |
| random | ~> 2.2 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |
| mongodbatlas | ~> 0.5 |
| random | ~> 2.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| stack\_identifier | Application and infrastructure stack identifier. Prepended to provisioned resources | `string` | `"marapp"` | no |
| environment\_name | Application and infrastructure environment name. Used to tag resources as belonging to the environment. (i.e. staging/rc/prod) | `string` | n/a | yes |
| aws\_region | AWS region into which to provision resources (i.e. us-east-1/us-west-1) | `string` | n/a | yes |
| vpc\_cidr | Addressable CIDR of the AWS VPC. | `string` | n/a | yes |
| availability\_zones | List of availability zones into which to provision subnets | `list` | n/a | yes |
| subnet\_cidrs | Addressable CIDRs for the availability zones' subnets | `list` | n/a | yes |
| private\_subnet\_cidrs | Addressable CIDRs for the availability zones' private subnets | `list` | n/a | yes |
| create\_mongodb\_atlas\_resources | Set to `true` to create MongoDB Atlas resources. | `bool` | `false` | no |
| mongodb\_atlas\_public\_key | Public key used to access the MongoDB Atlas API. To be used in conjunction with the `create_mongodb_atlas_resources` variable | `string` | `""` | no |
| mongodb\_atlas\_private\_key | Private key used to access the MongoDB Atlas API. To be used in conjunction with the `create_mongodb_atlas_resources` variable | `string` | `""` | no |
| mongodb\_atlas\_organization\_id | MongoDB Atlas organization. To be used in conjunction with the `create_mongodb_atlas_resources` variable | `string` | `""` | no |
| mongodb\_atlas\_project\_name | MongoDB Atlas project name. To be used in conjunction with the `create_mongodb_atlas_resources` variable | `string` | `""` | no |
| mongodb\_atlas\_cluster\_disk\_size | Disk size for the MongoDB Atlas cluster. To be used in conjunction with the `create_mongodb_atlas_resources` variable | `number` | `210` | no |
| mongodb\_atlas\_cluster\_disk\_iops | Provisioned IOPS for the MongoDB Atlas cluster. To be used in conjunction with the `create_mongodb_atlas_resources` variable | `number` | `630` | no |
| mongodb\_atlas\_cluster\_instance\_size | Instance size for the MongoDB Atlas cluster. To be used in conjunction with the `create_mongodb_atlas_resources` variable. Documented under `providerSettings.instanceSizeName`: https://docs.atlas.mongodb.com/reference/api/clusters-create-one/ | `string` | `"M40"` | no |
| mongodb\_atlas\_cluster\_aws\_region | AWS Region for the MongoDB Atlas cluster. To be used in conjunction with the `create_mongodb_atlas_resources` variable. Must corelate with the `aws_region` variable. . Documented under `providerSettings.regionName`: https://docs.atlas.mongodb.com/reference/api/clusters-create-one/ | `string` | `"US_EAST_1"` | no |
| create\_elasticache\_iam\_service\_linked\_role | Set to `true` to create an AWS IAM Service Linked Role for Elasticache. Leave `false` if you want to use your own Redis node _or_ an IAM Service Linked Role already exists for Elasticache | `bool` | `false` | no |
| create\_elasticache\_redis\_node | Set to `true` to create an AWS Elasticache Redis cluster. Leave `false` if you want to use your own Redis node | `bool` | `false` | no |
| elasticache\_redis\_node\_type | Node type of the AWS Elasticache Redis cluster. To be used in conjunction with the `create_elasticache_redis_node` variable. Documented here: https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/CacheNodes.SupportedTypes.html | `string` | `"cache.t2.small"` | no |
| create\_elasticsearch\_iam\_service\_linked\_role | Set to `true` to create an AWS IAM Service Linked Role for Elasticsearch. Leave `false` if you want to use your own Elasticsearch cluster _or_ an IAM Service Linked Role already exists for Elasticache | `bool` | `false` | no |
| create\_elasticsearch\_cluster | Set to `true` to create an AWS Elasticsearch 6.0 cluster. Leave `false` if you want to use your own Elasticsearch 6.0 node | `bool` | `false` | no |
| elasticsearch\_instance\_type | Instance type of the AWS Elasticsearch cluster. To be used in conjunction with the `create_elasticsearch_cluster` variable. Documented here: https://aws.amazon.com/elasticsearch-service/pricing/ | `string` | `"t2.small.elasticsearch"` | no |
| elasticsearch\_instance\_count | Number of instances in the AWS Elasticsearch cluster. To be used in conjunction with the `create_elasticsearch_cluster` variable. | `number` | `1` | no |
| elasticsearch\_instance\_disk\_volume\_size | Disk volume size of the instances in the AWS Elasticsearch cluster. To be used in conjunction with the `create_elasticsearch_cluster` variable. | `number` | `20` | no |

## Outputs

| Name | Description |
|------|-------------|
| mongodb\_sns\_publish\_access\_key\_id | AWS Access Key ID for MongoDB SNS publish user |
| mongodb\_sns\_publish\_secret\_key | AWS Secret Key for MongoDB SNS publish user |
| vpc\_id | Id of the provisioned AWS VPC |
| vpc\_subnets | Ids of the public subnets provisioned in the VPC |
| private\_vpc\_subnets | Ids of the private subnets provisioned in the VPC |
| redis\_cache\_nodes | Connection info for the AWS Elasticache Redis nodes. |
| elasticsearch\_endpoint | Connection info for the AWS Elasticsearch cluster. |
| vpc\_security\_group | Id of the default security group provisioned for the VPC |
| mongodb\_atlas\_user\_name | Generated username for MongoDB Atlas |
| mongodb\_atlas\_user\_password | Generated password for MongoDB Atlas |
| mongodb\_atlas\_database\_endpoints | Endpoints list for MongoDB Atlas |

