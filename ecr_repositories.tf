resource "aws_ecr_repository" "container_storage_eu_west_Ireland" {
  provider = "aws.aws_provider_eu_west_Ireland"
  name = "container_storage_eu_west_ireland"
}

resource "aws_ecr_repository" "container_storage_us_west_NCalifornia" {
  provider = "aws.aws_provider_us_west_NCalifornia"
  name = "container_storage_us_west_ncalifornia"
}