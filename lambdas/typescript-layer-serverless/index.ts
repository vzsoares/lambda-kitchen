import type { APIGatewayProxyResult } from 'aws-lambda';

const response = (
    statusCode: number,
    data = null,
    msg = null,
    code = '',
    err = [],
    cors = true,
): APIGatewayProxyResult => {
    const resp = {
        statusCode,
        body: JSON.stringify({
            msg,
            code,
            err,
            data,
        }),
        headers: {},
    };
    if (cors) {
        resp.headers = {
            'Access-Control-Allow-Origin': '*',
        };
    }

    return resp;
};

export default { response };
