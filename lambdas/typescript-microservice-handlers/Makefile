-include .env
export

.RECIPEPREFIX := >
.DEFAULT_GOAL := help

STAGE ?= dev
AWS_PROFILE ?= dev

deploy: ##@ Deploy to current $STAGE
> @echo "Deploying for stage: ${STAGE}"
> @sam deploy

build: ##@ Build to current $STAGE
> @echo "Building for stage: ${STAGE}"
> @sam package
