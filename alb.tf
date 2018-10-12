//resource "aws_lb" "aws_alb_ireland" {
//  provider = "aws.aws_provider_eu_west_Ireland"
//  name               = "albireland"
//  internal           = false
//  load_balancer_type = "application"
//  security_groups    = ["${aws_security_group.default-Ireland.id}"]
//  subnets            = ["${aws_subnet.public_subnet_Ireland.*.id}"]
//
//  enable_deletion_protection = true
//
////  access_logs {
////    bucket  = "${aws_s3_bucket}"
////    prefix  = "test-lb"
////    enabled = true
////  }
//
//  tags {
//    Environment = "production"
//  }
//}
