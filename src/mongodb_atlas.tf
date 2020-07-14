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

resource "mongodbatlas_project" "project" {
  count  = var.create_mongodb_atlas_resources ? 1 : 0
  name   = var.mongodb_atlas_project_name
  org_id = var.mongodb_atlas_organization_id

  lifecycle {
    ignore_changes = [
      teams
    ]
  }
}

resource "mongodbatlas_cluster" "cluster" {
  count      = var.create_mongodb_atlas_resources ? 1 : 0
  project_id = mongodbatlas_project.project[0].id
  name       = var.stack_identifier

  replication_factor           = 3
  provider_backup_enabled      = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.2"

  provider_name               = "AWS"
  disk_size_gb                = var.mongodb_atlas_cluster_disk_size
  provider_disk_iops          = var.mongodb_atlas_cluster_disk_iops
  provider_volume_type        = "STANDARD"
  provider_encrypt_ebs_volume = true
  provider_instance_size_name = var.mongodb_atlas_cluster_instance_size
  provider_region_name        = var.mongodb_atlas_cluster_aws_region
}

resource "mongodbatlas_private_endpoint" "private_endpoint" {
  count         = var.create_mongodb_atlas_resources ? 1 : 0
  project_id    = mongodbatlas_project.project[0].id
  provider_name = "AWS"
  region        = var.aws_region
}

resource "mongodbatlas_private_endpoint_interface_link" "private_endpoint_interface_link" {
  count                 = var.create_mongodb_atlas_resources ? 1 : 0
  project_id            = mongodbatlas_project.project[0].id
  private_link_id       = mongodbatlas_private_endpoint.private_endpoint[0].private_link_id
  interface_endpoint_id = aws_vpc_endpoint.mongodb_atlas_vpc_endpoint[0].id
}

resource "mongodbatlas_project_ip_whitelist" "ip_whitelist" {
  count      = var.create_mongodb_atlas_resources ? 1 : 0
  project_id = mongodbatlas_project.project[0].id
  cidr_block = var.vpc_cidr
  comment    = "${var.stack_identifier} AWS VPC CIDR"
}

resource "random_string" "mongodbatlas_database_user_password" {
  length           = 16
  special          = true
  override_special = "@£$"
}

resource "mongodbatlas_database_user" "user" {
  count              = var.create_mongodb_atlas_resources ? 1 : 0
  username           = "${var.stack_identifier}Admin"
  password           = random_string.mongodbatlas_database_user_password.result
  project_id         = mongodbatlas_project.project[0].id
  auth_database_name = "admin"

  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
}

output "mongodb_atlas_user_name" {
  description = "Generated username for MongoDB Atlas"
  value       = mongodbatlas_database_user.user.*.username
}

output "mongodb_atlas_user_password" {
  description = "Generated password for MongoDB Atlas"
  value       = mongodbatlas_database_user.user.*.password
}

output "mongodb_atlas_database_endpoints" {
  description = "Endpoints list for MongoDB Atlas"
  value       = mongodbatlas_cluster.cluster.*.connection_strings
}
