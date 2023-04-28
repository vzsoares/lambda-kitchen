"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = void 0;
const handler = async (event) => {
    const queries = JSON.stringify(event.queryStringParameters);
    return {
        statusCode: 200,
        body: JSON.stringify({ queries: `${queries}`, hi: "hello" }),
    };
};
exports.handler = handler;
