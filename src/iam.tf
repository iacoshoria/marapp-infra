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

resource "aws_iam_user" "mongodb_sns_publish" {
  name = "mongodb-sns-publish"

  tags = local.tags
}

resource "aws_iam_access_key" "mongodb_sns_publish" {
  user = aws_iam_user.mongodb_sns_publish.name
}

resource "aws_iam_policy" "sns_publish_policy" {
  name        = "sns-publish-policy"
  description = "SNS Publish Policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "sns-publish-policy-attachment"
  users      = [aws_iam_user.mongodb_sns_publish.name]
  policy_arn = aws_iam_policy.sns_publish_policy.arn
}

output "mongodb_sns_publish_access_key_id" {
  description = "AWS Access Key ID for MongoDB SNS publish user"
  value       = aws_iam_access_key.mongodb_sns_publish.id
}

output "mongodb_sns_publish_secret_key" {
  description = "AWS Secret Key for MongoDB SNS publish user"
  value       = aws_iam_access_key.mongodb_sns_publish.secret
}