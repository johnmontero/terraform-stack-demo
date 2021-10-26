.DEFAULT_GOAL := help

## INCLUDES ##
include makefiles/stack.mk
include makefiles/tf.mk

## GENERAL ##
OWNER            = terraform
TYPE_APP         = stack
SERVICE_NAME     = demo
AWS_REGION_BACKEND = us-east-1

ENV             ?= dev
AWS_REGION      ?= us-west-2
AWS_PROFILE     ?= default
AUTO_APPROVE    ?= -auto-approve
BUCKET_ACL      ?= private
BUCKET_NAME      = cds.$(OWNER).$(TYPE_APP).$(SERVICE_NAME).$(ENV)
PROJECT          = $(OWNER)-$(TYPE_APP)-$(SERVICE_NAME)-$(ENV)
STACK          	 = $(OWNER).$(TYPE_APP).$(SERVICE_NAME)


## HELP ##
help:
	@printf "\033[31m%-16s %-59s %s\033[0m\n" "Target" "Help" "Usage"; \
	printf "\033[31m%-16s %-59s %s\033[0m\n" "------" "----" "-----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-16s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'

