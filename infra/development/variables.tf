//variable "aws_access_key" {}
//
//variable "aws_access_secret_key" {}

variable "infrastructure_version" {
  type = "string"
  description = "Version of the infrastructure"
}

variable "domain" {
  type        = "string"
  description = "The domain name to use for short URLs."
}

variable "public_ssh_key" {
  type = "string"
  description = "SSH key for VM acess"
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

