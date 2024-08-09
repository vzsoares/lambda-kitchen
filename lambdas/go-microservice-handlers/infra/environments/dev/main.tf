locals {
  lambda_base_name = "go-microservice-handlers"
  gateway_name     = "lambda-kitchen"
  region           = "us-east-1"
  stage            = "dev"
  account_id       = "355738159777"
}

module "iam" {
  source = "../../modules/iam"
}

module "api_gateway" {
  source       = "../../modules/gateway"
  lambda_arn   = module.lambda.arn
  stage        = local.stage
  gateway_name = local.gateway_name
}

module "lambda" {
  source                = "../../modules/lambda"
  gateway_execution_arn = module.api_gateway.execution_arn
  stage                 = local.stage
  lambda_base_name      = local.lambda_base_name
  lambda_iam_arn        = module.iam.iam_role_arn
  filepath              = "../../../dist/zip/function.zip"
  s3_prefix             = "build/lambda/microservices"
  s3_bucket             = "zenhalab-artifacts-${local.stage}"
}

