variable "stage" {
  type = string
}
variable "gateway_id" {
  type = string
}
variable "gateway_execution_arn" {
  type = string
}
variable "lambda_iam_arn" {
  type = string
}

locals {
  base_route = "go-microservice-handlers"
  functions = {
    F1 = { "name" = "get-product", "route" = "GET /${local.base_route}/get-product" }
    F2 = { "name" = "put-product", "route" = "PUT /${local.base_route}/put-product" }
  }
}

module "lambda_function" {
  for_each = local.functions
  source   = "../../../infra/modules/lambda"

  gateway_id            = var.gateway_id
  gateway_execution_arn = var.gateway_execution_arn
  lambda_iam_arn        = var.lambda_iam_arn
  stage                 = var.stage

  gateway_route_key = each.value.route
  lambda_base_name  = "${local.base_route}-${each.value.name}"
  filepath          = "${path.module}/../functions/${each.value.name}"
  filename          = "function.zip"
  s3_prefix         = "build/lambda/lambda-kitchen"
  s3_bucket         = "zenhalab-artifacts-${var.stage}"
}
