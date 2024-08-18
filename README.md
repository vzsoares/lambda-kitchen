<h1 align="center">Lambda Kitchen</h1>

</br>
</br>

<p align="center"><img src="static/a-gif-wow.gif"/></p>

<p align="center">what's cooking? lambdas!</p>

## Available Lambdas/Layers

see at **`lambdas`** folder

<!-- https://tree.nathanfriend.io/?s=(%27options!(%27fancy!true~fullPath!false~trailingSlash!true~rootDot!false)~6(%276%27lambdas9.590http-5*7-awscli*lay34*.8express-8proxy4%27)~v3sion!%271%27)*2typescript-.micros3vice-7s-0monolithic-2%5Cn%20%203er4-s3v3less5t3raform6source!7handl38sam*092go-%01987654320.* -->

```
lambdas/
├── go-microservice-handlers-terraform
├── go-monolithic-http-terraform
├── typescript-handler-awscli
├── typescript-layer-serverless
├── typescript-microservice-handlers-sam
├── typescript-monolithic-express-sam
└── typescript-monolithic-proxy-serverless
```

### Requirements:

- make
- aws
- sam
- terraform
- go

### Usage:

```sh

yarn install

yarn nx -- <command>

###

# shows workspace graph
yarn nx -- graph

# show project individual commands
cd lambdas/<project> && make help

```

---

## Useful stuff:

### Use one bucket for all lambdas

by default serverless/sam creates one bucket for each lambda, and thats a problem because the account bucket limit is 100 by default

- [plugin: serverless-deployment-bucket](https://www.serverless.com/plugins/serverless-deployment-bucket)

- [samconfig](https://github.com/aws/aws-sam-cli/blob/develop/designs/sam-config.md)

### Api gateway custom domain

##### serverless:

[plugin: serverless-domain-manager](https://www.serverless.com/plugins/serverless-domain-manager)

[post](https://www.serverless.com/blog/serverless-api-gateway-domain/)

to stage path e.g www.domain/`dev`/images

Configure serverless-domain-manager config `basePath` to '${sls:stage}/'

### Environment variables:

##### serverless:

The best way is to use [aws SSM](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html), [see also](https://www.serverless.com/framework/docs/providers/aws/guide/variables#reference-variables-using-the-ssm-parameter-store)

And follow this pattern in serverless.yml:

```yaml
    MY_VAR: ${ssm:/${sls:stage}/MY_VAR}
```

> note the sls:stage, witch guarantees staging
> note that ssm var work like paths so they always start with a forward slash (/)

##### other:

- Add the vars after deploy with a script

or

- Use the cdk for iam/secrets manager

### Disable cloudwatch/Manage permissions

Do this to cut costs

Theres no cli option or config to that, but the best workaround is to manipulate permissions.

You either just disallow the cloudwatch or only allow lambda creation.

You could create a aws `role` or declare the policie directly on the yaml
example:

```yaml
#only allow functions
iam:
  role:
    statements:
      - Effect: 'Allow'
        Action:
          - 'lambda:InvokeFunction'
        Resource: '*'
```

[Policie to disallow cloudwatch](https://stackoverflow.com/questions/51166504/disable-cloudwatch-to-monitor-logs-for-lambda-function)
[Serverless iam docs](https://www.serverless.com/framework/docs/providers/aws/guide/iam)

## Links

- organize lambdas: https://aws.amazon.com/blogs/compute/best-practices-for-organizing-larger-serverless-applications/

- typescript power-tools: https://aws.amazon.com/blogs/compute/simplifying-serverless-best-practices-with-aws-lambda-powertools-for-typescript/

- memory optimization: https://theburningmonk.com/2020/03/how-to-optimize-lambda-memory-size-during-ci-cd-pipeline/
https://medium.com/geekculture/pick-the-right-memory-size-for-your-aws-lambda-functions-682394aa4b21

## Other Examples:

- monolithic go https://github.com/build-on-aws/golang-apis-on-aws-lambda
- microservice go https://github.com/aws-samples/serverless-go-demo
- monolithic typescript https://github.com/rodrigokamada/nodejs-aws-lambda