.DEFAULT_GOAL := help
.PHONY: help
help: ## show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; { \
		printf "\033[36m%-20s\033[0m %s\n", $$1, $$2 \
	}'

.PHONY: setup
setup:

.PHONY: build
build: ## build application
	go build -o bin/server

.PHONY: get
get:
	go get ./...

.PHONY: test
test:
	go test ./... -v
