<h1 align="center">Lambda Kitchen</h1>

</br>
</br>

<p align="center"><img src="assets/a-gif-wow.gif"/></p>

</br>
</br>

> <p align="center">what's cooking? lambdas!</p>

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

### Serverless creates one bucket for each lambda

[plugin: serverless-deployment-bucket](https://www.serverless.com/plugins/serverless-deployment-bucket)

### Api gateway custom domain

[plugin: serverless-domain-manager](https://www.serverless.com/plugins/serverless-domain-manager)

[post#](https://www.serverless.com/blog/serverless-api-gateway-domain/)

### Stage base path e.g www.domain/`dev`/images

Configure serverless-domain-manager config `basePath` to '${sls:stage}/'

## Links

- organize lambdas : https://aws.amazon.com/blogs/compute/best-practices-for-organizing-larger-serverless-applications/
