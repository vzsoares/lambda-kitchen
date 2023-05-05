#!/bin/bash

set -e 
set -o pipefail

[ -e function.zip ] && rm -f function.zip

[ -e dist ] && rm -f -r dist

node ./esbuild.js

yarn deploy

# TODO cleanup
# TODO enh scripts
