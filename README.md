<h1 align="center">Lambda Kitchen</h1>

</br>
</br>

<p align="center"><img src="assets/a-gif-wow.gif"/></p>

<p align="center">what's cooking? lambdas!</p>

## Available Lambdas/Layers

see at **`lambdas`** folder

### Lambdas:

- [Typescript/Serverless](https://github.com/vzsoares/lambda-kitchen)

- [Typescript/Zip](https://github.com/vzsoares/lambda-kitchen/tree/lambda-zip-typescript)

### Layers:

- [Typescript/Serverless](https://github.com/vzsoares/lambda-kitchen/tree/lambda-layer-utils)

## How to run:

env:

```
TODO=TODO
```

- configure aws credentials
  - install [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
  - run `aws configure`
    > - multiple accounts? [READ](https://www.serverless.com/framework/docs/providers/aws/guide/credentials/)
- `yarn install`
- develop locally `yarn debug`

---

## Organize your Lambdas

The way i suggest you to organize your lambdas is pretty simple

Basically is not a good idea to have to much code on one lambda, because that will increase its size and it will take longer to start up.

But its also a torture to have many repositories related to the same this.

So here the solution, following this marketplace example

### Marketplace microservice example:

req example: api.marketplace.domain/auth/validateToken

```yaml
.api.store/ #repoName=subdomain
├── auth/ #foldersName=subpath >>each are a lambda
│   ├── actions/
│   │   ├── validateToken.ts #actionName=path
│   │   └── createToken.ts
│   ├── tsconfig.json
│   ├── esbuild.json
│   ├── pretierrc.json
│   ├── eslint.json
│   ├── .gitignore
│   ├── deploy_prod.sh
│   ├── deploy_dev.sh
│   └── package.json
├── payments/
│   ├── actions/
│   │   ├── paymentIntention.ts
│   │   └── confirmPayment.ts
│   └── ...rest
└── products/
    ├── actions/
    │   ├── getProducts.ts
    │   └── getProductDetail.ts
    └── ...rest
```

<img src="assets/domain-folder.jpg" style="max-width:500px;"/>

Breaking it down, the repository name will represent the `service name` and will represent the _subdomain_ of our end api url

Then inside the repo we'll have folders that each are a lambda related to the service. So each one will have its own deploy and will represent different functions on aws
<br/>
The folder represents the _subpath_ and its name represents wat the actions inside of it are related to

Finally for the actions it basically is a function and its name relates to the _path_, it should be simple and do one thing well

## Useful stuff:

### Use one bucket for all lambdas

by default serverless create one bucket for each lambda, and thats a problem because the account bucket limit is 100 by default

[plugin: serverless-deployment-bucket](https://www.serverless.com/plugins/serverless-deployment-bucket)

### Api gateway custom domain

[plugin: serverless-domain-manager](https://www.serverless.com/plugins/serverless-domain-manager)

[post#](https://www.serverless.com/blog/serverless-api-gateway-domain/)

to stage path e.g www.domain/`dev`/images

Configure serverless-domain-manager config `basePath` to '${sls:stage}/'

### Environment variables:

The best way is to use aws [SSM](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html), [see also](https://www.serverless.com/framework/docs/providers/aws/guide/variables#reference-variables-using-the-ssm-parameter-store)
<br/>
And follow this pattern in serverless.yml

```yaml
    MY_VAR: ${ssm:/${sls:stage}/MY_VAR}

    # in runtime it would look like
    MY_VAR:  ${ssm:/dev/MY_VAR}
```

> note the sls:stage, witch guarantees staging

> note that ssm var work like paths so they always start with a forward slash (/)

to use it just do process.env.$MY_VAR

### Disable cloudwatch/Manage permissions

Theres no cli option or config to that, but the best workaround is to manipulate permissions.
<br/>
You either just disallow the cloudwatch or only allow lambda creation.
<br/>

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

[docs](https://www.serverless.com/framework/docs/providers/aws/guide/iam)

## Links

- organize lambdas: https://aws.amazon.com/blogs/compute/best-practices-for-organizing-larger-serverless-applications/

- typescript power-tools: https://aws.amazon.com/blogs/compute/simplifying-serverless-best-practices-with-aws-lambda-powertools-for-typescript/

- middlewares?: https://startup-cto.net/simplify-aws-lambda-functions-with-middleware/ ,
  https://github.com/siroop-ch/nodejs-lambda-middleware , https://dbartholomae.github.io/lambda-middleware/

- memory optimization: https://theburningmonk.com/2020/03/how-to-optimize-lambda-memory-size-during-ci-cd-pipeline/ , https://medium.com/geekculture/pick-the-right-memory-size-for-your-aws-lambda-functions-682394aa4b21
