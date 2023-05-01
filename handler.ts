import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";

export const handler = (event: APIGatewayProxyEvent): APIGatewayProxyResult => {
  const queries = JSON.stringify(event.queryStringParameters);
  return {
    statusCode: 200,
    body: JSON.stringify({ queries: `${queries}`, hi: "hello" }),
  };
};
