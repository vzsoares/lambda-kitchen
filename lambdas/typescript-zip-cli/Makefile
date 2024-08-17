-include .env
export

.RECIPEPREFIX := >
.DEFAULT_GOAL := help

STAGE ?= dev
AWS_PROFILE ?= dev

deploy: ##@ Deploy to current $STAGE
> @echo "Deploying for stage: ${STAGE}"
> @aws lambda update-function-code --function-name typescript-zip-cli --zip-file fileb://function.zip

build: ##@ Build to current $STAGE
> @echo "Building for stage: ${STAGE}"
> @node ./esbuild.js
> @zip -r -j function.zip dist/*

pre-build: ##@ Delete old artifacts
> @rm -rf dist

