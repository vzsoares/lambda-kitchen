import type { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';

import * as z from 'zod';

import sayHello from './actions/sayHello';

import helpers from '/opt/nodejs/lambda-layer/';

const handler = async (
  event: APIGatewayProxyEvent,
  fn: (event: APIGatewayProxyEvent) => Promise<APIGatewayProxyResult>,
) => {
  try {
    const result = await fn(event);

    return result;
  } catch (error) {
    console.error(error);

    if (error instanceof z.ZodError) {
      return helpers.response(400, null, error.issues);
    }

    return helpers.response(500, null, ['Internal server error']);
  }
};

export const sayHelloHandler = (e: APIGatewayProxyEvent) =>
  handler(e, sayHello);
