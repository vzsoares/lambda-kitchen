
#!/bin/bash
set -e 
set -o pipefail

[ -e function.zip ] && rm -f function.zip

[ -e dist ] && rm -f -r dist

yarn build

zip -r -j function.zip dist/*

aws lambda update-function-code --function-name i-say-hello --zip-file fileb://function.zip
