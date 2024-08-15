locals {
  region     = "us-east-1"
  stage      = "dev"
  account_id = "355738159777"
}

data "aws_iam_role" "role" {
  name = "lambda-role"
}

module "api_gateway" {
  source       = "../../modules/gateway"
  stage        = local.stage
  gateway_name = "lambda-kitchen"
}

module "go-microservice-handlers" {
  source = "../../../lambdas/go-microservice-handlers/infra"

  stage                 = local.stage
  gateway_id            = module.api_gateway.id
  gateway_execution_arn = module.api_gateway.execution_arn
  lambda_iam_arn        = data.aws_iam_role.role.arn
}

module "go-monolithic-http" {
  source = "../../../lambdas/go-monolithic-http/infra"

  stage                 = local.stage
  gateway_id            = module.api_gateway.id
  gateway_execution_arn = module.api_gateway.execution_arn
  lambda_iam_arn        = data.aws_iam_role.role.arn
}
