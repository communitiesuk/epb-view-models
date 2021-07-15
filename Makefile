.DEFAULT_GOAL := help
SHELL := /bin/bash

.PHONY: help install test format

help: ## Print help documentation
	@echo -e "Makefile Help for epb-auth-tools"
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Install required libraries and setup
	@bundle install

test: ## Run all tests
	@bundle exec rake spec

format: ## Runs Rubocop with the GOV.UK rules
	@bundle exec rake rubocop:auto_correct
