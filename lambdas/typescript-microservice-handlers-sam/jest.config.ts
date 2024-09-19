/* eslint-disable */
export default {
    displayName: 'typescript-microservice-handlers-sam',
    preset: '../../jest.preset.js',
    testEnvironment: 'node',
    transform: {
        '^.+\\.[tj]s$': [
            'ts-jest',
            { tsconfig: '<rootDir>/tsconfig.spec.json' },
        ],
    },
    moduleFileExtensions: ['ts', 'js', 'html'],
    coverageDirectory:
        '../../coverage/lambdas/typescript-microservice-handlers-sam',
};