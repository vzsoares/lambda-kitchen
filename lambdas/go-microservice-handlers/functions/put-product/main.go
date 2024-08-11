package main

import (
	"context"
	"encoding/json"
	"lambdas/go-microservice-handlers/store"
	"lambdas/go-microservice-handlers/tools"
	"lambdas/go-microservice-handlers/types"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(handler)
}

func handler(ctx context.Context, event events.APIGatewayV2HTTPRequest) (events.APIGatewayV2HTTPResponse, error) {
	product := types.Product{}
	if err := json.Unmarshal([]byte(event.Body), product); err != nil {
		return tools.GatewayErrResponse(500, err.Error()), nil
	}

	err := store.NewMemoryStore().Put(product)
	if err != nil {
		return tools.GatewayErrResponse(500, err.Error()), nil
	}

	return tools.GatewayResponse(200, nil), nil
}
