## This is $Helper layer

change `helper` for your projects name, it must be unique among your layers.
<br/>
<br/>
change it in:

- [ ] serverless.yaml
- [ ] package.json
- [ ] deploy.sh


## Usage:

import this layer locally and remotely with `/opt/nodejs/$layerName`

## Deploy:

dev `yarn deploy --aws-profile $PROFILE_NAME`

prod `yarn deploy:prod --aws-profile $PROFILE_NAME`

or `bash deploy.sh $STAGE $PROFILE_NAME`
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
