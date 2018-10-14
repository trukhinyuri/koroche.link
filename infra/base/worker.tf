////https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
//
//resource "aws_instance" "container_builder_Ireland" {
//  provider = "aws.aws_provider_eu_west_Ireland"
//  ami = "ami-05b65c0f6a75c1c64"
//  instance_type = "t2.nano"
//  private_ip = "10.0.0.13"
//  key_name = "${aws_key_pair.deployer_public_key.key_name}"
//  subnet_id = "${aws_subnet.public_subnet_Ireland.id}"
//  iam_instance_profile = "${aws_iam_instance_profile.ecs-instance-profile-Ireland.id}"
//
////  root_block_device {
////    volume_type = "standard"
////    volume_size = 100
////    delete_on_termination = true
////  }
//
//  lifecycle {
//    create_before_destroy = true
//  }
//
////  associate_public_ip_address = "false"
//
//}

