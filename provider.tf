provider "aws" {
  alias = "aws_provider_eu_west_Ireland"
//  access_key = "${var.aws_access_key}"
//  secret_key = "${var.aws_access_secret_key}"
  region     = "${var.aws_region_eu_west_Ireland}"
}

provider "aws" {
  alias  = "aws_provider_us_west_NCalifornia"
  region = "${var.aws_region_us_west_NCalifornia}"
}

provider "aws" {
  alias = "aws_provider_eu_central_Frankfurt"
  region = "${var.aws_region_eu_central_Frankfurt}"
}
