-include .env
export

.RECIPEPREFIX := >
.DEFAULT_GOAL := help

STAGE ?= dev
AWS_PROFILE ?= dev

deploy: ##@ Deploy to current $STAGE
> @echo "Deploying for stage: ${STAGE}"
> @npm exec -- sls deploy --stage ${STAGE} --aws-profile ${AWS_PROFILE}

build: ##@ Build to current $STAGE
> @echo "Building for stage: ${STAGE}"
> @npm exec -- sls package --stage ${STAGE} --aws-profile ${AWS_PROFILE}

serve: ##@ Start local api
> @npm exec -- sls offline start --stage ${STAGE}
