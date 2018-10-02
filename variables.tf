//variable "aws_access_key" {}
//
//variable "aws_access_secret_key" {}

variable "shortener_domain" {
  default = "koroche.link"
  type = "string"
  description = "The domain name to use for short URLs."
}

variable "env" {
  default = "dev"
  description = "The AWS reegion to use for the Short URL project."
}

variable "public_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAB/zMjYAMqqmWyZZ9H02kaCDEy+HUv88MNcwZ+mpxTDbXsH+mgsfF+hrcATChvJFhM+n4I3/ccANB9rZBBYPhu8CUI/bcgEHMEpB3LC5ROHHaArZWV7WV3Ns/WFEcWVk2czg77IYVPSj8GtT01ucZsKmphmhZHBlrFh7uuxoZv9H+bAwBILA8WKMxLzMlDk4mB8GYoZ7LFrNohsk+2GbPD36NSgncBAfYA5KJsj8Is1K1Mw1DuK/+PkXbKNp9blNqwK6P79A0YBXbF+aKmJO2j/fCFpAn5fzfTYj8+vn+qtr9ekYiPCaLQrZ/Hbi5B6hc8vmSQhx0RnU06ZVCCATsY4wZwuLp/Za/dob9dvjetJJRXXqr8fwpjlibaX0bAI0WNGw+O4PsRY47cbOrnvCBB/dqCYKD3GVGg0IJ3YIEstLMcr7mHifGLAMAzevhuSuUjNWEvNzmlhfM5NO8B4SLeBFB4Xp8+4HYflcv4Q7VXfN97n6pFGurZFp7e4ugfRu9szoTP9lxeWzJDuI8RReUUvTE0AHPYdBIo7aOXP1Sa/PRWzk3BQTpF5O5FgFGbSbcXHsml3AtOZDX74gISyLUR4Cu6lrKNe2OSlH1JLesfxnQtT5bW1/2hCMtjdJzqdcSTJvU7KB++BF6xoZeVuw/SOTewDBjFKPvET6rOIdzm80M= trukhinyuri@MacBook-Pro.local"
}

//variable "aws_region_main" {
//  default = "eu-west-1" //Ireland
//  description = "The AWS reegion to use for the Short URL project."
//}
//
//variable "aws_region_mainUS" {
//  default = "us-east-1" //N. Virginia
//  description = "The AWS reegion to use for the Short URL project."
//}
//
//variable "s3_bucket_name" {
//  default = "shortener_bucket"
//  description = "The AWS reegion to use for the Short URL project."
//}


//variable "account_id" {
//  type = "string"
//  description = "Your AWS account ID."
//}
