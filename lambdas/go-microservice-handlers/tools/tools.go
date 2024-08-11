package tools

import (
	"encoding/json"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
)

func GatewayResponse(code int, object interface{}) events.APIGatewayV2HTTPResponse {
	marshalled, err := json.Marshal(object)
	if err != nil {
		return GatewayErrResponse(http.StatusInternalServerError, err.Error())
	}

	return events.APIGatewayV2HTTPResponse{
		StatusCode: code,
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
		Body:            string(marshalled),
		IsBase64Encoded: false,
	}
}

func GatewayErrResponse(status int, body string) events.APIGatewayV2HTTPResponse {
	message := map[string]string{
		"message": body,
	}

	messageBytes, _ := json.Marshal(&message)

	return events.APIGatewayV2HTTPResponse{
		StatusCode: status,
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
		Body: string(messageBytes),
	}
}
