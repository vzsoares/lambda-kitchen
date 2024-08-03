import type { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';

//@ts-expect-error layer life
import helpers from '/opt/nodejs/lambda-layer/'; // eslint-disable-line

const sayHello = async (
    event: APIGatewayProxyEvent,
): Promise<APIGatewayProxyResult> => {
    const queries = JSON.stringify(event.queryStringParameters);

    return helpers.response(200, { hi: 'hello', queries: `${queries}` });
};

export default sayHello;
