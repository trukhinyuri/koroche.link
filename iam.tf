resource "aws_iam_policy" "policy_DynamoDB_FullAccess" {
  provider = "aws.aws_provider_eu_west_Ireland"
  name        = "DynamoDB_FullAccess"
  path        = "/"
  description = "DynamoDB_FullAccess"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeReservedCapacityOfferings",
                "dynamodb:ListGlobalTables",
                "dynamodb:TagResource",
                "dynamodb:UntagResource",
                "dynamodb:ListTables",
                "dynamodb:DescribeReservedCapacity",
                "dynamodb:ListBackups",
                "dynamodb:PurchaseReservedCapacityOfferings",
                "dynamodb:ListTagsOfResource",
                "dynamodb:DescribeTimeToLive",
                "dynamodb:DescribeLimits",
                "dynamodb:ListStreams"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "dynamodb:*",
            "Resource": "arn:aws:dynamodb:*:*:table/*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "dynamodb:*",
            "Resource": [
                "arn:aws:dynamodb:*:*:table/*/index/*",
                "arn:aws:dynamodb:*:*:table/*/stream/*",
                "arn:aws:dynamodb:*:*:table/*/backup/*",
                "arn:aws:dynamodb::*:global-table/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role" "role_ECS_tasks_Dynamo" {
  assume_role_policy = ""
}
