#!/bin/bash

set -e 
set -o pipefail

[ -e function.zip ] && rm -f function.zip

[ -e dist ] && rm -f -r dist

STAGE=$1
AWS_PROFILE=$2

test -n "$STAGE" || \
(echo "No essential arg variables provided" && false)

LAYER_NAME="helpers"
FINAL_PATH="./lib/nodejs/$LAYER_NAME"

node ./esbuild.js

mkdir -p "$FINAL_PATH" && cp -r dist/* "$FINAL_PATH" && \
(cd "$FINAL_PATH" && npm init -y 1> /dev/null)

# sls deploy --stage $STAGE --aws-profile $AWS_PROFILE

echo "SUCCESS"

# TODO sudo ln -sf 'here' /opt/nodejs
# TODO gen types