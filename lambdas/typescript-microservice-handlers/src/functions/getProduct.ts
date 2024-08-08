import type { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import db from '../../db.stub.json';

export function handler(event: APIGatewayProxyEvent): APIGatewayProxyResult {
    const id = event.pathParameters?.['id'];
    const product = db.find((p) => p.id === id);

    if (!product) return { statusCode: 404, body: '' };

    return { statusCode: 200, body: JSON.stringify(product) };
}
