import type { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';

import helpers from '/opt/nodejs/lambda-layer/';

const sayHello = async (
  event: APIGatewayProxyEvent,
): Promise<APIGatewayProxyResult> => {
  const queries = JSON.stringify(event.queryStringParameters);

  return helpers.response(200, { hi: 'hello', queries: `${queries}` });
};

export default sayHello;
