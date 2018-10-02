resource "aws_key_pair" "deployer_public_key" {
  provider = "aws.aws_provider_eu_west_Ireland"
  key_name   = "deployer-key"
  public_key = "${var.public_ssh_key}"
}
