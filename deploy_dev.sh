
#!/bin/bash
set -e 
set -o pipefail

[ -e function.zip ] && rm -f function.zip

[ -e dist ] && rm -f -r dist

node ./esbuild.js

zip -r -j function.zip dist/*

aws lambda update-function-code --function-name i-say-hello-dev --zip-file fileb://function.zip
