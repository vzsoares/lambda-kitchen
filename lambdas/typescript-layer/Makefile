-include .env
export

.RECIPEPREFIX := >
.DEFAULT_GOAL := help

STAGE ?= dev
AWS_PROFILE ?= dev
LAYER_NAME="helpers"
FINAL_PATH="./lib/nodejs/${LAYER_NAME}"

deploy: ##@ Deploy to current $STAGE
> @echo "Deploying for stage: ${STAGE}"
> @npm sls deploy --stage ${STAGE} --aws-profile ${AWS_PROFILE}

build: ##@ Build to current $STAGE
> @echo "Building for stage: ${STAGE}"
> @node ./esbuild.js

pre-build: ##@ Delete old artifacts
> @rm -rf dist lib types

post-build: ##@ Create layer folder
> @mkdir -p "${FINAL_PATH}" && cp -r dist/* "${FINAL_PATH}" && \
(cd "${FINAL_PATH}" && yarn init -y 1> /dev/null)

declare:
> @yarn tsc index.ts --declaration --allowJs --emitDeclarationOnly --outDir types

link:
> @mkdir -p /opt/nodejs
> @sudo ln -sf `pwd` /opt/nodejs/
