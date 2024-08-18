-include .env
export

.RECIPEPREFIX := >
.DEFAULT_GOAL := help

SAM := sam
STAGE ?= dev
AWS_PROFILE ?= dev

deploy: ##@ Deploy to current $STAGE
> @echo "Deploying for stage: ${STAGE}"
> @${SAM} deploy

build: ##@ Build to current $STAGE
> @echo "Building for stage: ${STAGE}"
> @${SAM} build

serve: ##@ Start local api
> @SAM_CLI_BETA_ESBUILD=1 ${SAM} local start-api --beta-features --debug --skip-pull-image

