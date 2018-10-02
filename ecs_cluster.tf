resource "aws_ecs_cluster" "ecs_cluster_Ireland" {
  provider = "aws.aws_provider_eu_west_Ireland"
  name = "ecs_cluster_Ireland"
}