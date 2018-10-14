resource "aws_vpc" "vpc_Ireland" {
  provider             = "aws.aws_provider_eu_west_Ireland"
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "vpc_Ireland"
  }
}

locals {
  subnet_count = 3
  availability_zones = ["${var.aws_region_eu_west_Ireland}a", "${var.aws_region_eu_west_Ireland}b", "${var.aws_region_eu_west_Ireland}c"]
}

resource "aws_subnet" "terraform-blue-green_subnet" {
  provider = "aws.aws_provider_eu_west_Ireland"
  count = "${local.subnet_count}"
  cidr_block = "10.1.${local.subnet_count * (var.infrastructure_version - 1) + count.index + 1}.0/24"
  availability_zone = "${element(local.availability_zones, count.index)}"
  vpc_id = "${aws_vpc.vpc_Ireland.id}"
  map_public_ip_on_launch = true

  tags {
    Name = "${element(local.availability_zones, count.index)} (v${var.infrastructure_version})"
  }
}

resource "aws_security_group" "terraform-blue-green" {
  provider = "aws.aws_provider_eu_west_Ireland"
  description = "Terraform Blue/Green"
  vpc_id      = "${aws_vpc.vpc_Ireland.id}"
  name        = "terraform-blue-green-v${var.infrastructure_version}"

  tags {
    Name = "Terraform Blue/Green (v${var.infrastructure_version})"
  }
}

resource "aws_security_group_rule" "terraform-blue-green-inbound" {
  provider = "aws.aws_provider_eu_west_Ireland"
  type              = "ingress"
  security_group_id = "${aws_security_group.terraform-blue-green.id}"
  from_port         = -1
  to_port           = 0
  protocol          = "-1"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "terraform-blue-green-outbound" {
  provider = "aws.aws_provider_eu_west_Ireland"
  type              = "egress"
  security_group_id = "${aws_security_group.terraform-blue-green.id}"
  from_port         = -1
  to_port           = 0
  protocol          = "-1"

  cidr_blocks = ["0.0.0.0/0"]
}

//resource "aws_internet_gateway" "gw_Ireland" {
//  provider = "aws.aws_provider_eu_west_Ireland"
//  vpc_id   = "${aws_vpc.vpc_Ireland.id}"
//
//  tags {
//    Name = "gw_Ireland"
//  }
//}
//
////Elastic IP for NAT
//resource "aws_eip" "nat_eip_Ireland" {
//  provider   = "aws.aws_provider_eu_west_Ireland"
//  vpc        = true
//  depends_on = ["aws_internet_gateway.gw_Ireland"]
//}
//
//resource "aws_nat_gateway" "nat_Ireland" {
//  provider      = "aws.aws_provider_eu_west_Ireland"
//  allocation_id = "${aws_eip.nat_eip_Ireland.id}"
//  subnet_id     = "${element(aws_subnet.public_subnet_Ireland.*.id, 0)}"
//  depends_on    = ["aws_internet_gateway.gw_Ireland"]
//}
//
//resource "aws_subnet" "public_subnet_Ireland" {
//  provider                = "aws.aws_provider_eu_west_Ireland"
//  cidr_block              = "10.0.0.0/24"
//  vpc_id                  = "${aws_vpc.vpc_Ireland.id}"
//  map_public_ip_on_launch = true
//}
//
//resource "aws_subnet" "private_subnet_Ireland" {
//  provider                = "aws.aws_provider_eu_west_Ireland"
//  cidr_block              = "10.0.1.0/24"
//  vpc_id                  = "${aws_vpc.vpc_Ireland.id}"
//  map_public_ip_on_launch = false
//}
//
//resource "aws_route_table" "private_route_table_Ireland" {
//  provider = "aws.aws_provider_eu_west_Ireland"
//  vpc_id   = "${aws_vpc.vpc_Ireland.id}"
//}
//
//resource "aws_route_table" "public_route_table_Ireland" {
//  provider = "aws.aws_provider_eu_west_Ireland"
//  vpc_id   = "${aws_vpc.vpc_Ireland.id}"
//}
//
//resource "aws_route" "public_internet_gateway_Ireland" {
//  provider               = "aws.aws_provider_eu_west_Ireland"
//  route_table_id         = "${aws_route_table.public_route_table_Ireland.id}"
//  destination_cidr_block = "0.0.0.0/0"
//  gateway_id             = "${aws_internet_gateway.gw_Ireland.id}"
//}
//
//resource "aws_route" "private_nat_gateway" {
//  provider               = "aws.aws_provider_eu_west_Ireland"
//  route_table_id         = "${aws_route_table.private_route_table_Ireland.id}"
//  destination_cidr_block = "0.0.0.0/0"
//  nat_gateway_id         = "${aws_nat_gateway.nat_Ireland.id}"
//}
//
///* Route table associations */
//resource "aws_route_table_association" "public" {
//  provider       = "aws.aws_provider_eu_west_Ireland"
//  count          = "${length("10.0.0.0/24")}"
//  subnet_id      = "${element(aws_subnet.public_subnet_Ireland.*.id, count.index)}"
//  route_table_id = "${aws_route_table.public_route_table_Ireland.id}"
//}
//
//resource "aws_route_table_association" "private" {
//  provider       = "aws.aws_provider_eu_west_Ireland"
//  count          = "${length("10.0.1.0/24")}"
//  subnet_id      = "${element(aws_subnet.private_subnet_Ireland.*.id, count.index)}"
//  route_table_id = "${aws_route_table.private_route_table_Ireland.id}"
//}
//
///*====
//VPC's Default Security Group
//======*/
//resource "aws_security_group" "default-Ireland" {
//  provider    = "aws.aws_provider_eu_west_Ireland"
//  name        = "Ireland-default-sg"
//  description = "Default security group to allow inbound/outbound from the VPC"
//  vpc_id      = "${aws_vpc.vpc_Ireland.id}"
//  depends_on  = ["aws_vpc.vpc_Ireland"]
//
//  ingress {
//    from_port   = "0"
//    to_port     = "65535"
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  egress {
//    from_port   = "0"
//    to_port     = "65535"
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}
