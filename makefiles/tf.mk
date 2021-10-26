.PHONY: init \
		plan \
		apply \
		destroy \
		help

envs:
	$(eval ACCOUNT_ID = $(shell aws sts get-caller-identity --query "Account"))
	$(eval BUCKET_STATE = "terraform.tfstate.$(ACCOUNT_ID).$(AWS_REGION)")
	$(eval BUCKET_STATE_EXIST = $(shell aws s3api head-bucket --bucket $(BUCKET_STATE) 2>&1 || true))

tf.backend: envs
	@if [ ! -z "$(BUCKET_STATE_EXIST)" ]; then \
		aws s3api create-bucket \
			--bucket $(BUCKET_STATE) \
			--acl private \
			--region $(AWS_REGION_BACKEND); \
	fi

tf.init: tf.backend envs ## Inicializar terraform: make tf.init
	@export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform && terraform init \
		-backend-config bucket=$(BUCKET_STATE) \
		-backend-config key="stacks/$(ENV)/$(OWNER)-$(TYPE_APP)-$(SERVICE_NAME)/terraform.tfstate"

tf.update: ## Actualizar recursos: make tf.update
	@cd terraform && terraform get -update

tf.plan: ## Plan add, change o remove de recursos: make tf.plan
	@export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform && terraform plan \
		-var 'project=$(PROJECT)' \
		-var 'environment=$(ENV)' \
		-var 'region=$(AWS_REGION)' \
		-var 'bucket_name=$(BUCKET_NAME)' \
		-var 'bucket_acl=$(BUCKET_ACL)'

tf.apply: ## Aplicar add, change o remove de recursos: make tf.apply
	@export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform && terraform apply $(AUTO_APPROVE) \
		-var 'project=$(PROJECT)' \
		-var 'environment=$(ENV)' \
		-var 'region=$(AWS_REGION)' \
		-var 'bucket_name=$(BUCKET_NAME)' \
		-var 'bucket_acl=$(BUCKET_ACL)'

tf.destroy: ## Eliminar despliegue de la infraestructur: make tf.destroy
	@export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform && terraform destroy $(AUTO_APPROVE) \
		-var 'project=$(PROJECT)' \
		-var 'environment=$(ENV)' \
		-var 'region=$(AWS_REGION)' \
		-var 'bucket_name=$(BUCKET_NAME)' \
		-var 'bucket_acl=$(BUCKET_ACL)'
