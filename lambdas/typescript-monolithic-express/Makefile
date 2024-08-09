-include .env
export

.RECIPEPREFIX := >
.DEFAULT_GOAL := help

DOCKER := docker
AWS := aws
SAM := sam
AWK := awk

##@
##@ Run local
##@

serve: ##@ Start local api
> @SAM_CLI_BETA_ESBUILD=1 ${SAM} local start-api --beta-features --debug --skip-pull-image

##@
##@ Misc commands
##@

help: ##@ (Default) This help menu
> @printf "\nUsage: make <command>\n"
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
