import type { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import db from '../../db.stub.json';

export async function handler(
    event: APIGatewayProxyEvent,
): Promise<APIGatewayProxyResult> {
    const id = event.pathParameters?.['id'];
    const product = db.find((p) => p.id === id);
    console.log('ASDSAD@!@#@#@!$', product);

    if (!product) return { statusCode: 404, body: '' };

    return { statusCode: 200, body: JSON.stringify(product) };
}
