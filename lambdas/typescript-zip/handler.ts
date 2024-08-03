import type { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';

export const handler = async (
    event: APIGatewayProxyEvent,
): Promise<APIGatewayProxyResult> => {
    const queries = JSON.stringify(event.queryStringParameters);
    return {
        statusCode: 200,
        body: JSON.stringify({ queries: `${queries}`, hi: 'hello' }),
    };
};
