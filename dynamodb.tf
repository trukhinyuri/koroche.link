resource "aws_dynamodb_table" "dynamodb_table_Ireland" {
  provider = "aws.aws_provider_eu_west_Ireland"
  "attribute" {
    name = "slug"
    type = "S"
  }
  hash_key = "slug"
  name = "url_shortener"
  read_capacity = 1
  write_capacity = 1
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}

resource "aws_dynamodb_table" "dynamodb_table_NCalifornia" {
  provider = "aws.aws_provider_us_west_NCalifornia"
  "attribute" {
    name = "slug"
    type = "S"
  }
  hash_key = "slug"
  name = "url_shortener"
  read_capacity = 1
  write_capacity = 1
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}

//resource "aws_dynamodb_global_table" "dynamo_db_global_url_shortener" {
//  depends_on = ["aws_dynamodb_table.dynamodb_table_Ireland", "aws_dynamodb_table.dynamodb_table_NCalifornia"]
//  provider = "aws.aws_provider_eu_west_Ireland"
//  name = "url_shortener"
//
//
//  replica {
//    region_name = "${var.aws_region_us_west_NCalifornia}"
//  }
//
//  replica {
//    region_name = "${var.aws_region_eu_west_Ireland}"
//  }
//}