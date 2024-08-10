locals {
  gateway_name = "lambda-kitchen"
  region       = "us-east-1"
  stage        = "dev"
  account_id   = "355738159777"
}

data "aws_iam_role" "role" {
  name = "lambda-role"
}

module "api_gateway" {
  source       = "../../modules/gateway"
  stage        = local.stage
  gateway_name = local.gateway_name
}

module "get-product-lambda" {
  source                = "../../modules/lambda"
  gateway_id            = module.api_gateway.id
  gateway_execution_arn = module.api_gateway.execution_arn
  stage                 = local.stage
  lambda_iam_arn        = data.aws_iam_role.role.arn
  lambda_base_name      = "go-microservice-handlers-get-product"
  filepath              = "../../../functions/get-product/function.zip"
  s3_prefix             = "build/lambda/lambda-kitchen"
  s3_bucket             = "zenhalab-artifacts-${local.stage}"
}

