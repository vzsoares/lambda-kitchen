import type { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import db from '../../db.stub.json';
import { writeFileSync } from 'fs';

export async function handler(
    event: APIGatewayProxyEvent,
): Promise<APIGatewayProxyResult> {
    const product = JSON.parse(event.body ?? '""');

    if (!product) return { statusCode: 404, body: '' };

    writeFileSync(
        '../../db.stub.json',
        JSON.stringify({ ...db, product }),
        'utf8',
    );

    return { statusCode: 200, body: '' };
}
