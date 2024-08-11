locals {
  region     = "us-east-1"
  stage      = "dev"
  account_id = "355738159777"
  base_route = "go-microservice-handlers"
  functions = {
    F1 = { "name" = "get-product", "route" = "GET /${local.base_route}/get-product" }
    F2 = { "name" = "put-product", "route" = "PUT /${local.base_route}/put-product" }
  }
}

data "aws_iam_role" "role" {
  name = "lambda-role"
}

module "api_gateway" {
  source       = "../../modules/gateway"
  stage        = local.stage
  gateway_name = "lambda-kitchen"
}

module "lambda_function" {
  for_each = local.functions
  source   = "../../modules/lambda"

  gateway_id            = module.api_gateway.id
  gateway_execution_arn = module.api_gateway.execution_arn
  stage                 = local.stage
  lambda_iam_arn        = data.aws_iam_role.role.arn
  gateway_route_key     = each.value.route

  lambda_base_name = "${local.base_route}-${each.value.name}"
  filepath         = "../../../functions/${each.value.name}"
  filename         = "function.zip"
  s3_prefix        = "build/lambda/lambda-kitchen"
  s3_bucket        = "zenhalab-artifacts-${local.stage}"
}
