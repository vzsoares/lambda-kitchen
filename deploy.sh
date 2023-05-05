#!/bin/bash

set -e 
set -o pipefail

[ -e function.zip ] && rm -f function.zip

[ -e dist ] && rm -f -r dist

LAYER_NAME="helpers"
FINAL_PATH="dist/nodejs/node_modules/$LAYER_NAME"

node ./esbuild.js

for filename in helpers/*; do
    [ -e "$filename" ] || continue
     if [ "${filename##*.}" != "ts" ]; then
       cp "$filename" "$FINAL_PATH"
     fi
done

yarn deploy

# TODO cleanup
# TODO enh scripts
