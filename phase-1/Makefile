.DEFAULT_GOAL := help
.PHONY: help prune up down sh

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%-20s\033[0m %s\n", $$1, $$2}'

prune: ## Remove unused images and prune volumes
	docker system prune --all --volumes --force

up: ## Spin up containers
	docker-compose up --detach

down: ## Take down containers
	docker-compose down

sh: ## Attach a shell to the running container
	docker exec -it postgres psql -d postgres -U postgres

rm: ## Remove postgres volume
	docker volume rm soen-363-phase-1_pg-363-p1
