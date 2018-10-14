resource "aws_vpc" "vpc_Ireland_legacy" {
  provider             = "aws.aws_provider_eu_west_Ireland"
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "vpc_Ireland"
  }
}

resource "aws_internet_gateway" "gw_Ireland_legacy" {
  provider = "aws.aws_provider_eu_west_Ireland"
  vpc_id   = "${aws_vpc.vpc_Ireland.id}"

  tags {
    Name = "gw_Ireland"
  }
}

//Elastic IP for NAT
resource "aws_eip" "nat_eip_Ireland_legacy" {
  provider   = "aws.aws_provider_eu_west_Ireland"
  vpc        = true
  depends_on = ["aws_internet_gateway.gw_Ireland_legacy"]
}

resource "aws_nat_gateway" "nat_Ireland_legacy" {
  provider      = "aws.aws_provider_eu_west_Ireland"
  allocation_id = "${aws_eip.nat_eip_Ireland_legacy.id}"
  subnet_id     = "${element(aws_subnet.public_subnet_Ireland_legacy.*.id, 0)}"
  depends_on    = ["aws_internet_gateway.gw_Ireland_legacy"]
}

resource "aws_subnet" "public_subnet_Ireland_legacy" {
  provider                = "aws.aws_provider_eu_west_Ireland"
  cidr_block              = "10.0.0.0/24"
  vpc_id                  = "${aws_vpc.vpc_Ireland.id}"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_Ireland_legacy" {
  provider                = "aws.aws_provider_eu_west_Ireland"
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = "${aws_vpc.vpc_Ireland.id}"
  map_public_ip_on_launch = false
}

resource "aws_route_table" "private_route_table_Ireland_legacy" {
  provider = "aws.aws_provider_eu_west_Ireland"
  vpc_id   = "${aws_vpc.vpc_Ireland.id}"
}

resource "aws_route_table" "public_route_table_Ireland_legacy" {
  provider = "aws.aws_provider_eu_west_Ireland"
  vpc_id   = "${aws_vpc.vpc_Ireland.id}"
}

resource "aws_route" "public_internet_gateway_Ireland_legacy" {
  provider               = "aws.aws_provider_eu_west_Ireland"
  route_table_id         = "${aws_route_table.public_route_table_Ireland_legacy.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw_Ireland_legacy.id}"
}

resource "aws_route" "private_nat_gateway_legacy" {
  provider               = "aws.aws_provider_eu_west_Ireland"
  route_table_id         = "${aws_route_table.private_route_table_Ireland_legacy.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_Ireland_legacy.id}"
}

/* Route table associations */
resource "aws_route_table_association" "public_legacy" {
  provider       = "aws.aws_provider_eu_west_Ireland"
  count          = "${length("10.0.0.0/24")}"
  subnet_id      = "${element(aws_subnet.public_subnet_Ireland_legacy.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table_Ireland_legacy.id}"
}

resource "aws_route_table_association" "private_legacy" {
  provider       = "aws.aws_provider_eu_west_Ireland"
  count          = "${length("10.0.1.0/24")}"
  subnet_id      = "${element(aws_subnet.private_subnet_Ireland_legacy.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_route_table_Ireland_legacy.id}"
}

/*====
VPC's Default Security Group
======*/
resource "aws_security_group" "default-Ireland_legacy" {
  provider    = "aws.aws_provider_eu_west_Ireland"
  name        = "Ireland-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc_Ireland_legacy.id}"
  depends_on  = ["aws_vpc.vpc_Ireland"]

  ingress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
