package main

import (
	"context"
	"lambdas/go-microservice-handlers-terraform/store"
	"lambdas/go-microservice-handlers-terraform/tools"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(handler)
}

func handler(ctx context.Context, event events.APIGatewayV2HTTPRequest) (events.APIGatewayV2HTTPResponse, error) {
	id, ok := event.QueryStringParameters["id"]
	if !ok {
		return tools.GatewayResponse(404, nil), nil
	}

	p, err := store.NewMemoryStore().Get(id)
	if err != nil {
		return tools.GatewayErrResponse(500, err.Error()), nil
	}

	return tools.GatewayResponse(200, p), nil
}
