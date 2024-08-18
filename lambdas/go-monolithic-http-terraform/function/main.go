package main

import (
	"context"
	"fmt"
	"net/http"
	"time"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/awslabs/aws-lambda-go-api-proxy/httpadapter"
)

var GET = "GET"
var PUT = "PUT"

var httpLambda *httpadapter.HandlerAdapter

func buildPath(p string, m *string) string {
	var res string
	if m == nil {
		res = fmt.Sprint("/go-monolithic-http-terraform", p)
	} else {
		res = fmt.Sprint(*m, " /go-monolithic-http-terraform", p)
	}
	return res
}

func init() {
	http.HandleFunc(buildPath("/ping", nil), func(w http.ResponseWriter, r *http.Request) {
		HttpRespond(w, http.StatusOK, time.UnixDate)
	})

	http.HandleFunc(buildPath("/product", &GET), GetProduct)
	http.HandleFunc(buildPath("/product", &PUT), PutProduct)

	httpLambda = httpadapter.New(http.DefaultServeMux)
}

func Handler(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return httpLambda.ProxyWithContext(ctx, req)
}

func main() {
	lambda.Start(Handler)
}
