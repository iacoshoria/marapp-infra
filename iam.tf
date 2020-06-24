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