# container image build and push to ECR
.PHONY: ecr-push

IMAGE_NAME = hello-world-job

ecr-push:
	@bash -c '\
		IMAGE_TAG=$$(date "+%Y%m%d-%H%M"); \
		ACCOUNT_ID=$$(aws sts get-caller-identity --query Account --output text); \
		ECR_REPO=$${ACCOUNT_ID}.dkr.ecr.$${AWS_DEFAULT_REGION}.amazonaws.com; \
		IMAGE_URI=$${ECR_REPO}/$(IMAGE_NAME):$${IMAGE_TAG}; \
		PARAMETER_NAME=/ecs/$(IMAGE_NAME)/release; \
		echo "docker build -t $(IMAGE_NAME):$${IMAGE_TAG} ."; \
		docker build -t $(IMAGE_NAME):$${IMAGE_TAG} .; \
		echo "aws ecr get-login-password --region $$AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $${ECR_REPO}"; \
		aws ecr get-login-password --region $$AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $${ECR_REPO}; \
		docker tag $(IMAGE_NAME):$${IMAGE_TAG} $${IMAGE_URI}; \
		docker push $${IMAGE_URI}; \
		aws ssm put-parameter --name=$${PARAMETER_NAME} --value=$${IMAGE_TAG} --type String --overwrite; \
	'
