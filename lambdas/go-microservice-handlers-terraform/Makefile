-include .env
export

.RECIPEPREFIX := >
.DEFAULT_GOAL := help

DOCKER ?= docker
AWS ?= aws
SAM ?= sam
TERRAFORM ?= terraform
AWK ?= awk
GO ?= go
MAKE ?= make

FUNCTIONS := get-product put-product

STAGE ?= dev

BASE_TF_WORK_DIR=../../infra/environments

SAM_COMMON_AGRS=--hook-name terraform --beta-features
SAM_TERRAFORM_ROOT=--terraform-project-root-path ../../../

##@
##@ Build
##@

build: ##@ Build package
> @echo "Building for stage: ${STAGE}"
> @${MAKE} $(foreach function,${FUNCTIONS}, build-${function}) -j

build-%:
> @echo "Building $*"
> @cd ./functions/$* && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o bootstrap -tags lambda.norpc
> @cd ./functions/$* && zip -X -r -j function.zip bootstrap ../../db.stub.json

##@
##@ Run local SAM
##@

sam-build: ##@ Build for sam
> @make build && cd ${BASE_TF_WORK_DIR}/${STAGE} && ${SAM} build ${SAM_COMMON_AGRS} ${SAM_TERRAFORM_ROOT} ${EXTRA}

start: ##@ Start local api
       ##@ - if this is your first run then
       ##@ run make tf-init && make sam-build
> @make watch-build start-api -j

start-api:
> @cd ${BASE_TF_WORK_DIR}/${STAGE} && ${SAM} local start-api --debug --skip-pull-image ${SAM_COMMON_AGRS}

watch-build:
> @npx nodemon -e go --signal SIGTERM --exec 'make' sam-build EXTRA=--skip-prepare-infra

##@
##@ Deployment
##@

deploy: ##@ Deploy to current $STAGE
> @echo "Deploying for stage: ${STAGE}"
> @make build
> @cd ${BASE_TF_WORK_DIR}/${STAGE} && ${TERRAFORM} init && ${TERRAFORM} apply -auto-approve

##@
##@ Terraform
##@

tf-%: ##@ run Terraform %
> @cd ${BASE_TF_WORK_DIR}/${STAGE} && ${TERRAFORM} $*

##@
##@ Misc commands
##@

help: ##@ (Default) This help menu
> @printf "\nUsage: STAGE=dev make <command>\n"
> @grep -F -h "##@" $(MAKEFILE_LIST) | grep -F -v grep -F | sed -e 's/\\$$//' | $(AWK) 'BEGIN {FS = ":*[[:space:]]*##@[[:space:]]*"}; \
	{ \
		if($$2 == "") \
			pass; \
		else if($$0 ~ /^#/) \
			printf "\n%s\n", $$2; \
		else if($$1 == "") \
			printf "     %-20s%s\n", "", $$2; \
		else \
      printf "\n    \033[38;2;156;207;216m%-20s\033[0m %s\n", $$1, $$2; \
	}'
