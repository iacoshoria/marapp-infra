resource "aws_iam_user" "mongodb_sns_publish" {
  name = "mongodb-sns-publish"

  tags = local.tags
}

resource "aws_iam_access_key" "mongodb_sns_publish" {
  user = aws_iam_user.mongodb_sns_publish.name
}

output "mongodb_sns_publish_access_key_id" {
  description = "AWS Access Key ID for MongoDB SNS publish user"
  value       = aws_iam_access_key.mongodb_sns_publish.id
}

output "mongodb_sns_publish_secret_key" {
  description = "AWS Secret Key for MongoDB SNS publish user"
  value       = aws_iam_access_key.mongodb_sns_publish.secret
}