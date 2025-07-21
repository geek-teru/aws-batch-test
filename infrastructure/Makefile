.PHONY: init

init:
	docker compose run --rm terraform init -reconfigure

.PHONY: plan

plan:
	docker compose run --rm terraform plan

.PHONY: apply

apply:
	docker compose run --rm terraform apply --auto-approve