resource "aws_ecs_cluster" "ecs_cluster_Ireland" {
  provider = "aws.aws_provider_eu_west_Ireland"
  name = "ecs_cluster_Ireland"
}

resource "aws_ecs_task_definition" "appTaskDefinition" {
  provider = "aws.aws_provider_eu_west_Ireland"
  container_definitions = "${file("task-definitions/service.json")}"
  family = "appTaskDefinition"
  task_role_arn = ""
}

resource "aws_ecs_service" "ecs_service_runner" {
  provider = "aws.aws_provider_eu_west_Ireland"
  name = "ecs_service_runner"
  task_definition = "appTaskDefinition"
}