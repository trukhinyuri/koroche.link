terraform {
  backend "s3" {
    encrypt = true
    bucket  = "terraform-bluegreen-plugndo"
    region  = "eu-west-1"
    key     = "v1"
  }
}