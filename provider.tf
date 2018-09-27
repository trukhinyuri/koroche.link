provider "aws" {
//  access_key = "${var.aws_access_key}"
//  secret_key = "${var.aws_access_secret_key}"
  region     = "${var.aws_region_main}"
}

provider "aws" {
  region = "us-east-1"
  alias  = "cloudfront_acm"
}

provider "archive" {
}
