resource "aws_ecs_cluster" "ecs_cluster_Ireland" {
  provider = "aws.aws_provider_eu_west_Ireland"
  name     = "ecs_cluster_Ireland"
}

resource "aws_ecs_task_definition" "appTaskDefinition" {
  provider              = "aws.aws_provider_eu_west_Ireland"
  container_definitions = "${file("task-definitions/service.json")}"
  family                = "appTaskDefinition"

  //  task_role_arn = "${aws_iam_role.ec2_instance_role.arn}"
  //  execution_role_arn = "${aws_iam_role.ec2_instance_role.arn}"
  network_mode = "bridge"
}

resource "aws_ecs_service" "ecs_service_app_runner" {
  provider        = "aws.aws_provider_eu_west_Ireland"
  name            = "ecs_service_runner"
  cluster         = "${aws_ecs_cluster.ecs_cluster_Ireland.id}"
  task_definition = "${aws_ecs_task_definition.appTaskDefinition.arn}"
  desired_count   = 1

  //  iam_role = "${aws_iam_role.ec2_instance_role.arn}"

  //  load_balancer {
  //    target_group_arn = "${aws_lb.aws_alb_ireland.arn}"
  //    container_name = "app"
  //    container_port = 80
  //  }
}
