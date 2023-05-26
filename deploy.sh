#!/bin/bash

set -e 
set -o pipefail

LAYER_NAME="helpers"
FINAL_PATH="./lib/nodejs/$LAYER_NAME"

STAGE=$1
AWS_PROFILE=$2

test -n "$STAGE" && test -n "$AWS_PROFILE" || \
(echo "No essential arg variables provided" && false)

[ -e function.zip ] && rm -f function.zip

[ -e dist ] && rm -f -r dist

node ./esbuild.js

mkdir -p "$FINAL_PATH" && cp -r dist/* "$FINAL_PATH" && \
(cd "$FINAL_PATH" && npm init -y 1> /dev/null)

npm sls deploy --stage $STAGE --aws-profile $AWS_PROFILE

echo "SUCCESS"
