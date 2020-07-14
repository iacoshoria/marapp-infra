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

resource "aws_elasticsearch_domain" "es" {
  count                 = var.create_elasticsearch_cluster ? 1 : 0
  domain_name           = var.stack_identifier
  elasticsearch_version = "6.0"

  cluster_config {
    instance_type            = var.elasticsearch_instance_type
    instance_count           = var.elasticsearch_instance_count
    dedicated_master_enabled = false
    zone_awareness_enabled   = false
  }

  vpc_options {
    subnet_ids         = [element(module.vpc.public_subnets, 0)]
    security_group_ids = [module.vpc.default_security_group_id]
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.elasticsearch_instance_disk_volume_size
  }

  depends_on = [
    aws_iam_service_linked_role.es[0]
  ]

  tags = local.tags
}

resource "aws_iam_service_linked_role" "es" {
  count = var.create_elasticsearch_iam_service_linked_role && var.create_elasticsearch_cluster ? 1 : 0

  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain_policy" "main" {
  count       = var.create_elasticsearch_cluster ? 1 : 0
  domain_name = aws_elasticsearch_domain.es[0].domain_name

  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "${aws_elasticsearch_domain.es[0].arn}/*"
        }
    ]
}
POLICIES
}

output "elasticsearch_endpoint" {
  description = "Connection info for the AWS Elasticsearch cluster."
  value = aws_elasticsearch_domain.es.*.endpoint
}