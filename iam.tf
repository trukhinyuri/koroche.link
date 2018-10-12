data "aws_iam_policy_document" "ec2_instance_assume_role_policy" {
  provider = "aws.aws_provider_eu_west_Ireland"
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "ec2_instance_role" {
  provider = "aws.aws_provider_eu_west_Ireland"
  assume_role_policy = "${data.aws_iam_policy_document.ec2_instance_assume_role_policy.json}"
  name = "ec2_instance_role_ireland"
  path = "/"
}

resource "aws_iam_policy" "DynamoDB_FullAccess" {
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

resource "aws_iam_role_policy_attachment" "apploDynamoDBAccessFromEC2" {
  provider = "aws.aws_provider_eu_west_Ireland"
  policy_arn = "${aws_iam_policy.DynamoDB_FullAccess.arn}"
  role = "${aws_iam_role.ec2_instance_role.name}"
}

resource "aws_iam_instance_profile" "ecs-instance-profile-Ireland" {
  provider = "aws.aws_provider_eu_west_Ireland"
  name = "ecs-instance-profile-ireland"
  path="/"
  role = "${aws_iam_role.ec2_instance_role.id}"
  provisioner "local-exec" {
    command = "sleep 60"
  }
}