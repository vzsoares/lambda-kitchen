## API Gateway
resource "aws_apigatewayv2_api" "gateway" {
  name          = var.gateway_name
  protocol_type = "HTTP"
  cors_configuration {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }
  disable_execute_api_endpoint = true

  tags = {
    Terraform = "true"
    stage     = var.stage
  }
}

resource "aws_apigatewayv2_stage" "gateway" {
  api_id = aws_apigatewayv2_api.gateway.id

  name        = "v1"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "gateway_integration" {
  api_id = aws_apigatewayv2_api.gateway.id

  integration_uri    = var.lambda_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "gateway_route" {
  api_id = aws_apigatewayv2_api.gateway.id

  route_key = "GET /go-microservice-handlers/get-product"
  target    = "integrations/${aws_apigatewayv2_integration.gateway_integration.id}"
}

resource "aws_apigatewayv2_api_mapping" "mapping" {
  api_id          = aws_apigatewayv2_api.gateway.id
  domain_name     = "api${var.stage == "dev" ? "-dev" : ""}.zenhalab.com"
  stage           = aws_apigatewayv2_stage.gateway.id
  api_mapping_key = "lambda-kitchen/v1"
}
