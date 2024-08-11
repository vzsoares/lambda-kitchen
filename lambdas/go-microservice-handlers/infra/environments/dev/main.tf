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

module "get-product-lambda" {
  source                = "../../modules/lambda"
  gateway_id            = module.api_gateway.id
  gateway_execution_arn = module.api_gateway.execution_arn
  stage                 = local.stage
  lambda_iam_arn        = data.aws_iam_role.role.arn
  gateway_route_key     = "GET /go-microservice-handlers/get-product"
  lambda_base_name      = "go-microservice-handlers-get-product"
  filepath              = "../../../functions/get-product"
  filename              = "function.zip"
  s3_prefix             = "build/lambda/lambda-kitchen"
  s3_bucket             = "zenhalab-artifacts-${local.stage}"
}

module "put-product-lambda" {
  source                = "../../modules/lambda"
  gateway_id            = module.api_gateway.id
  gateway_execution_arn = module.api_gateway.execution_arn
  stage                 = local.stage
  lambda_iam_arn        = data.aws_iam_role.role.arn
  gateway_route_key     = "PUT /go-microservice-handlers/put-product"
  lambda_base_name      = "go-microservice-handlers-put-product"
  filepath              = "../../../functions/put-product"
  filename              = "function.zip"
  s3_prefix             = "build/lambda/lambda-kitchen"
  s3_bucket             = "zenhalab-artifacts-${local.stage}"
}
